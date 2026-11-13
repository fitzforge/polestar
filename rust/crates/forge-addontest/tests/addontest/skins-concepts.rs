//! The five concept skins in the download (Hairline, Umbra, Waymark, Lanterns, Sheen), one load test each:
//! the skin's addon names its skin in its TOC to load on demand, loads after Polestar on its own, registers
//! through the Skin API with nothing refused and nothing corrected, and in every variant it has paints every surface it covers (the guide window and its
//! progress, the arrow, a step pin and a map mark, the alert toast, the settings window on its Theme page)
//! without a painter or hook raising; then what makes each skin itself is checked: Hairline's own art and
//! light face are in its folder and its preset gives the class colour; Umbra's vignette and steel edge (the
//! vignette alone on the game looks its variants draw on) and its dim over those looks' art, the guide window's
//! lit goal and progress bar included; Waymark's chart paper, compass rose and the
//! continent's picture, its colour following the continent, a heads-up card's rose at its foot; Lanterns'
//! rounded window and its two lights in each mood but Plain; Sheen's bevelled, glossed glass pane and its pins
//! in the class colour.

use forge_addontest::run::root;
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

// The pieces every skin paints, in every variant: the guide window (its layout and progress), the alert
// toast's sample, the settings window on the Theme page, a step pin and a map mark (the pin hook and the
// skin's pin art), the arrow (repainted on each theme change).
const PAINT_ALL: &str = r#"
local T = Polestar.Theme
local function paintAll()
	Polestar.UI.GuideFrame.Layout()
	if Polestar.Nav and Polestar.Nav.alerts and Polestar.Nav.alerts.ShowSample then Polestar.Nav.alerts.ShowSample() end
	Polestar.UI.ShowOptions("theme")
	Polestar.UI.Materials.Show()
	local P = Polestar.Pins
	if P and P.BuildLook then
		stepPin = stepPin or CreateFrame("Frame", nil, UIParent)
		if not stepPin.fill then P.BuildLook(stepPin) end
		P.ApplyLook(stepPin, { color = { 1, 0.84, 0.45, 1 }, text = "2" }, 16)
		mapMark = mapMark or CreateFrame("Frame", nil, UIParent)
		if not mapMark.fill then P.BuildLook(mapMark) end
		P.ApplyLook(mapMark, { icon = "map:quest-available", color = { 1, 0.84, 0.45, 1 } }, 16)
	end
	stub.advance(1)
end
-- Each variant of skin `id` (none: the skin alone) picked and painted.
local function eachVariant(id, variants, fn)
	local runs = #variants > 0 and variants or { false }
	for _, v in ipairs(runs) do
		if v then Polestar.Set("ui.skinVariants." .. id, v) end
		Polestar.Set("ui.skin", id)
		paintAll()
		fn(v)
	end
end
local function hexOf(c) return c and ("%02x%02x%02x"):format(math.floor(c[1] * 255 + 0.5), math.floor(c[2] * 255 + 0.5), math.floor(c[3] * 255 + 0.5)) end
-- What the skin in use keeps on the guide window (its kit store): each key
-- -> how many of its textures are shown (a texture: 1 or 0).
local function kept()
	local own = T.SkinKit.store(PolestarGuideFrame)
	local out = {}
	for k, v in pairs(own) do
		if type(v) == "table" then
			if v.IsShown then
				out[k] = v:IsShown() and 1 or 0
			else
				local n = 0
				for _, t in pairs(v) do if type(t) == "table" and t.IsShown and t:IsShown() then n = n + 1 end end
				out[k] = n
			end
		end
	end
	return out
end
"#;

/// Polestar and one skin addon, the player a level-18 Tauren Hunter, `script` after PAINT_ALL; the
/// registration notes (refused, corrected) and the checks of every variant are added to its output.
fn run(addon: &str, id: &str, variants: &[&str], before: &str, script: &str) -> Value {
	let v = variants.iter().map(|v| format!("{v:?}")).collect::<Vec<_>>().join(", ");
	let script = format!(
		r#"{PAINT_ALL}
local out = {{ id = {id:?}, notes = {{}}, runs = {{}} }}
for _, l in ipairs(Polestar.DebugLog(800)) do
	if tostring(l):find("({addon}", 1, true) then out.notes[#out.notes + 1] = tostring(l) end
end
local listed
for _, c in ipairs(T.SkinChoices()) do if c.value == {id:?} then listed = c.addon end end
out.listed = listed or false
Polestar.Set("ui.shown", true)
eachVariant({id:?}, {{ {v} }}, function(variant)
	local info = T.SkinInfo({id:?})
	out.runs[#out.runs + 1] = {{ variant = variant or false, inUse = T.SkinId() == {id:?},
		failed = info and info.failed or false, legible = T.Legibility(T.Palette()) >= 1 }}
end)
{script}
emit(out)
"#
	);
	let before = format!(
		"stub.world.race, stub.world.raceName, stub.world.class, stub.world.className, stub.world.faction = \
		 'Tauren', 'Tauren', 'HUNTER', 'Hunter', 'Horde'\nstub.world.level = 18\n{before}"
	);
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar"), Addon::name(addon)], login: true, script, ..Default::default() }).remove(0)
}

fn loads_and_paints(out: &Value, addon: &str, variants: &[&str]) {
	// Loaded on demand: only a player who picks the skin pays for it (Polestar loads it for the saved skin,
	// on a pick and when the settings list the skins, by the id its TOC names).
	let toc = std::fs::read_to_string(root().join("addon").join(addon).join(format!("{addon}.toc"))).unwrap();
	let id = out["id"].as_str().unwrap();
	assert!(toc.lines().any(|l| l.trim() == "## LoadOnDemand: 1"), "{addon} loads on demand");
	assert!(toc.lines().any(|l| l.trim() == format!("## X-Polestar-Skin: {id}")), "{addon} names its skin {id} in its TOC");
	// An empty Lua table is emitted as {} (no array to tell it by).
	let notes = &out["notes"];
	assert!(notes.as_array().is_some_and(Vec::is_empty) || notes.as_object().is_some_and(serde_json::Map::is_empty), "{addon}: refused or corrected: {notes}");
	assert_eq!(out["listed"], addon, "{addon}: in the skin picker with its addon");
	let runs = out["runs"].as_array().unwrap();
	assert_eq!(runs.len(), variants.len().max(1), "{addon}: every variant painted");
	for r in runs {
		let v = &r["variant"];
		assert_eq!(r["inUse"], true, "{addon} {v}: in use once picked");
		assert_eq!(r["failed"], false, "{addon} {v}: a painter or hook raised (the skin would be switched off)");
		assert_eq!(r["legible"], true, "{addon} {v}: legible as painted");
	}
}

#[test]
fn hairline_loads_paints_everything_and_brings_its_own_dart_pins_font_and_class_accent() {
	let addon = "Polestar_Skin_Hairline";
	let out = run(
		addon,
		"hairline",
		&[],
		"",
		r#"
out.media = { dart = T.SkinMedia("dart"), dartEdge = T.SkinMedia("dartEdge"), medallion = T.SkinMedia("medallion") }
out.arrow = T.SkinArrowStyle()
T.ApplySkinPreset("hairline")
stub.advance(1)
local r, g, b = T.ClassColor("HUNTER")
out.accent, out.hunter = hexOf({ T.Accent() }), hexOf({ r, g, b })
"#,
	);
	loads_and_paints(&out, addon, &[]);
	assert_eq!(out["arrow"], "halo", "the skins' dart style, with Hairline's own dart");
	let dir = root().join("addon").join(addon);
	for key in ["dart", "dartEdge", "medallion"] {
		let p = out["media"][key].as_str().unwrap_or_else(|| panic!("media.{key} given"));
		let rel = p.strip_prefix(&format!("Interface\\AddOns\\{addon}\\")).unwrap_or_else(|| panic!("media.{key} in its own folder: {p}"));
		let file = dir.join(format!("{}.tga", rel.replace('\\', "/")));
		assert!(file.is_file(), "media.{key}: {} is in the addon", file.display());
	}
	for face in ["Light", "Regular", "Medium"] {
		assert!(dir.join(format!("Fonts/BarlowSemiCondensed-{face}.ttf")).is_file(), "Barlow Semi Condensed {face} ships");
	}
	assert!(dir.join("Fonts/BarlowSemiCondensed-OFL.txt").is_file(), "the font's licence ships beside it");
	assert_eq!(out["accent"], out["hunter"], "the preset makes the accent the class colour");
}

#[test]
fn umbra_loads_paints_everything_in_each_variant_and_its_variants_dim_the_games_looks() {
	let addon = "Polestar_Skin_Umbra";
	let variants = ["flat", "forever", "blizzard", "classic"];
	let out = run(
		addon,
		"umbra",
		&variants,
		"",
		r#"
out.keys, out.kept = {}, {}
eachVariant("umbra", { "flat", "forever", "blizzard", "classic" }, function(v) out.keys[v] = T.SkinKey(); out.kept[v] = kept() end)
out.scheme = T.SchemeInfo("umbra") ~= nil
"#,
	);
	loads_and_paints(&out, addon, &variants);
	assert_eq!(out["scheme"], true, "the Umbra scheme registers beside the skin");
	assert_eq!(out["keys"], serde_json::json!({ "flat": "polestar", "forever": "forever", "blizzard": "blizzard", "classic": "classic" }), "each variant draws on its own base look");
	let (flat, forever) = (&out["kept"]["flat"], &out["kept"]["forever"]);
	assert_eq!((flat["vignette"].as_i64(), flat["edge"].as_i64(), flat["glow"].as_i64()), (Some(4), Some(4), Some(4)), "Flat: the vignette and the steel edge on all four sides: {flat}");
	assert_eq!((forever["vignette"].as_i64(), forever["edge"].as_i64()), (Some(4), Some(0)), "the game looks keep the vignette alone: {forever}");
}

// Umbra's dimmed variants: its dim (the cool grey 0.82, 0.84, 0.88 at 55 %, 85 % grey) lies over the game look's
// lit goal and every piece of the guide window's progress bar (the fill, the art round it, the ground under it) as
// over its frames: drawn dimmed, dimmed again on a repaint. Flat, picked while Umbra is in use, puts the game look's
// bar and lit goal away and draws Polestar's own progress line as it did before any game look, nothing grey.
// Each piece: its colour and alpha, and its grey (the client's desaturation).
#[test]
fn umbra_s_dimmed_variants_dim_the_guide_window_s_lit_goal_and_progress_bar_and_flat_puts_them_away() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: r#"C_Texture = { GetAtlasInfo = function(name)
	return { file = "atlas:" .. name, leftTexCoord = 0, rightTexCoord = 1, topTexCoord = 0, bottomTexCoord = 1, width = 234, height = 24 }
end }"#
			.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"]), Addon::name("Polestar_Skin_Umbra")],
		script: r#"uistub.install()
stub.login()
local GF = Polestar.UI.GuideFrame
uistub.openTabs({ { uistub.elwynn, 3 } }, 1)
local function piece(t)
	if not (t and t:IsShown()) then return false end
	local r, g, b, a = t:GetVertexColor()
	return { r, g, b, a, t.desaturation or 0 }
end
local function litGoal()
	for _, r in ipairs(GF.rows) do
		local t = r.psSkin and r.psSkin.kit and r.psSkin.kit.rowLit
		if t and t:IsShown() then return t end
	end
end
-- A game look's pieces: its lit goal, and every texture of its progress bar shown: the bar's own fill (unless
-- the look draws its own), the ground under it and each piece of art the look keeps on it, by key.
local function pieces()
	local bar = GF.parts.foot.Status
	bar:SetWidth(200)
	bar:SetValue(0.5)
	local own = bar:GetStatusBarTexture()
	local out = { lit = piece(litGoal()), ground = piece(bar.Bg), fill = (own:GetAlpha() or 1) > 0 and piece(own) or nil }
	local function texture(t) return type(t) == "table" and t.GetObjectType and t:GetObjectType() == "Texture" end
	for key, v in pairs(bar.psSkin.kit) do
		if texture(v) then
			out[key] = v:IsShown() and piece(v) or nil
		elseif type(v) == "table" and not v.GetObjectType then
			for i, t in ipairs(v) do
				if texture(t) and t:IsShown() then out[key .. i] = piece(t) end
			end
		end
	end
	return out
end
-- Flat: Polestar's own progress line; the game look's bar (made the first time a game look shows) and lit goal.
local function flat()
	local bar = rawget(GF.parts.foot, "Status")
	return { line = piece(GF.parts.foot.Line.Fill), bar = bar and bar:IsShown() or false, lit = litGoal() ~= nil }
end
Polestar.Set("ui.skin", "umbra")
local out = { flat = flat(), looks = {} }
for _, look in ipairs({ "forever", "blizzard", "classic" }) do
	Polestar.Set("ui.skin", look)
	local plain = pieces()
	Polestar.Set("ui.skinVariants.umbra", look)
	Polestar.Set("ui.skin", "umbra")
	local dim = pieces()
	GF.Render()
	local again = pieces()
	Polestar.Set("ui.skinVariants.umbra", "flat")
	out.looks[look] = { plain = plain, dim = dim, again = again, flat = flat() }
end
emit(out)"#
			.into(),
		..Default::default()
	})
	.remove(0);
	let near = |v: &Value, want: f64| v.as_f64().is_some_and(|x| (x - want).abs() < 1e-6);
	// Umbra's DIM: { tint = { 0.82, 0.84, 0.88, 1 }, brightness = -0.45, desaturate = 0.85 }.
	let dim = |plain: &Value, i: usize| (plain[i].as_f64().unwrap() * [0.82, 0.84, 0.88][i] * 0.55).min(1.0);
	for look in ["forever", "blizzard", "classic"] {
		let o = &out["looks"][look];
		let plain = o["plain"].as_object().unwrap();
		let fill = if plain.contains_key("statusFill") { "statusFill" } else { "fill" };
		for part in ["lit", fill, "ground"] {
			assert!(plain.get(part).is_some_and(Value::is_array), "{look}: the {part} drawn: {o}");
		}
		for (part, p0) in plain {
			assert!(near(&p0[4], 0.0), "{look}: the {part} drawn in the look's own colours: {p0}");
			for when in ["dim", "again"] {
				let p = &o[when][part];
				let dimmed = (0..3).all(|i| near(&p[i], dim(p0, i))) && near(&p[3], p0[3].as_f64().unwrap()) && near(&p[4], 0.85);
				assert!(dimmed, "{look} ({when}): the {part} in Umbra's dim, from {p0}: {p}");
			}
		}
		for when in ["dim", "again"] {
			assert_eq!(o[when].as_object().unwrap().len(), plain.len(), "{look} ({when}): the same pieces as the look draws: {o}");
		}
		assert_eq!(o["flat"], out["flat"], "{look}: Flat, picked while Umbra is in use, puts the game look away and draws its line as before");
	}
	let flat = &out["flat"];
	assert!(flat["line"].is_array() && near(&flat["line"][4], 0.0), "Flat: Polestar's own progress line, not grey: {flat}");
	assert_eq!((&flat["bar"], &flat["lit"]), (&Value::Bool(false), &Value::Bool(false)), "Flat: no game bar, no lit goal of a game look's: {flat}");
}

#[test]
fn waymark_loads_paints_everything_and_its_colour_follows_the_continent_and_a_card_keeps_its_rose_at_the_foot() {
	let addon = "Polestar_Skin_Waymark";
	let out = run(
		addon,
		"waymark",
		&[],
		r#"
local w = stub.world
w.addMap(1414, { name = "Kalimdor", mapType = 2 })
w.addMap(1415, { name = "Eastern Kingdoms", mapType = 2 })
w.addMap(1411, { name = "Durotar", parent = 1414, left = 0, right = -1000, top = 1000, bottom = 0 })
w.addMap(1429, { name = "Elwynn Forest", parent = 1415, left = 0, right = -1000, top = 1000, bottom = 0 })
w.addMap(9999, { name = "Somewhere", left = 0, right = -1000, top = 1000, bottom = 0 })
w.moveTo(1411, 50, 50)
w.zone = "Durotar"
"#,
		r#"
local function at(map, zone)
	stub.world.moveTo(map, 50, 50)
	stub.world.setZone(zone)
	stub.advance(1)
	return hexOf(T.Palette().accent)
end
out.kalimdor = at(1411, "Durotar")
out.kept = kept()
out.eastern = at(1429, "Elwynn Forest")
out.elsewhere = at(9999, "Somewhere")
out.back = at(1411, "Durotar")
-- A heads-up card over the guide window: its card hook's small rose at the foot, none of the window's in the
-- corner (under the card's badge and close box).
local CT = Polestar.UI.ClassToast
local q = CT.Candidates(stub.world.level, "any")
out.card = q[1] and CT.Show(q[1]) and true or false
stub.advance(1)
local own = T.SkinKit.store(PolestarClassToast)
local foot = own.overlay and T.SkinKit.store(own.overlay).rose
out.cardRose = { corner = own.rose and own.rose:IsShown() or false, foot = foot and foot:IsShown() or false }
"#,
	);
	loads_and_paints(&out, addon, &[]);
	assert_eq!(out["kalimdor"], "d9a441", "Kalimdor ochre");
	assert_eq!((out["kept"]["paper"].as_i64(), out["kept"]["rose"].as_i64()), (Some(1), Some(1)), "the chart paper and the compass rose: {}", out["kept"]);
	assert_eq!(out["kept"]["gameArt:waymark"].as_i64(), Some(1), "the continent's picture behind the header");
	assert_eq!(out["eastern"], "9bb35a", "Eastern Kingdoms moss");
	assert_eq!(out["elsewhere"], "e6ba66", "off a continent: Polestar gold");
	assert_eq!(out["back"], "d9a441", "and back again");
	assert_eq!(out["card"], true, "a heads-up card shows");
	assert_eq!(out["cardRose"], serde_json::json!({ "corner": false, "foot": true }), "the card's rose: its hook's at the foot, not the window's in the corner");
}

#[test]
fn lanterns_loads_paints_everything_in_all_ten_moods_each_with_its_pair_of_colours() {
	let addon = "Polestar_Skin_Lanterns";
	let variants = ["forge", "tidepool", "glade", "hoarfrost", "duskrose", "starfall", "ashen", "highsun", "gloam", "plain"];
	let out = run(
		addon,
		"lanterns",
		&variants,
		"",
		r#"
out.moods = {}
for _, m in ipairs(T.SkinVariants("lanterns") or {}) do out.moods[#out.moods + 1] = m.id end
out.pairs, out.kept = {}, {}
eachVariant("lanterns", out.moods, function(v)
	local pal = T.Palette()
	out.pairs[v] = { hexOf(pal.accent), hexOf(pal.accent2) }
	out.kept[v] = kept()
end)
"#,
	);
	loads_and_paints(&out, addon, &variants);
	assert_eq!(out["moods"], serde_json::json!(variants), "the ten moods, in order, under the skin's card");
	assert_eq!(out["pairs"]["forge"], serde_json::json!(["ff8a3d", "ffd36b"]), "Forge: ember and gold");
	assert_eq!(out["pairs"]["tidepool"], serde_json::json!(["3fc8c0", "4f86ff"]), "Tidepool: teal and blue");
	let plain = &out["pairs"]["plain"];
	assert_eq!(plain[0], plain[1], "Plain has one colour (no lights)");
	let (forge, plain) = (&out["kept"]["forge"], &out["kept"]["plain"]);
	assert_eq!((forge["ground"].as_i64(), forge["rim"].as_i64()), (Some(9), Some(8)), "the rounded window: a nine-slice ground and its eight-piece rim: {forge}");
	assert_eq!((forge["glow:near"].as_i64(), forge["glow:far"].as_i64()), (Some(1), Some(1)), "Forge's two lights");
	assert_eq!((plain["glow:near"].as_i64(), plain["glow:far"].as_i64()), (Some(0), Some(0)), "Plain has no lights");
}

#[test]
fn sheen_loads_paints_everything_and_its_pins_take_the_class_colour() {
	let addon = "Polestar_Skin_Sheen";
	let out = run(
		addon,
		"sheen",
		&[],
		"",
		r#"
local r, g, b = T.SkinToken("pinRing")
local cr, cg, cb = T.ClassColor("HUNTER")
out.ring, out.hunter = r and hexOf({ r, g, b }) or false, hexOf({ cr, cg, cb })
out.kept = kept()
"#,
	);
	loads_and_paints(&out, addon, &[]);
	assert_eq!(out["ring"], out["hunter"], "the pins' rims in the class colour");
	let k = &out["kept"];
	for part in ["bevelTop", "bevelFoot", "bevelLeft", "bevelRight", "gloss", "glare", "glow:sheen"] {
		assert_eq!(k[part].as_i64(), Some(1), "the glass pane's {part}: {k}");
	}
}
