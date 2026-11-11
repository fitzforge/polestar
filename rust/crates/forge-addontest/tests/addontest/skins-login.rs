//! The game's looks as a login builds them (#1802): the look is in PolestarDB before ADDON_LOADED, not switched
//! to. The guide window was skinned before it was marked the guide window, so its first paint was the big windows'
//! (Polestar_Looks/GameSkins.lua BIG: a "Polestar" title bar and a drag strip 500 levels over the window), which
//! nothing took away: the strip lay over the bottom row of the card above the window (Later, Turn these off; the
//! level-up spells, old ranks and update cards too). And the banner's close in the game's looks: at its own 24 unit
//! target the red button stood larger than the card's and anything round it. Against the real Core + Theme + UI
//! manifests and the fake Engine (tests/lua/stub_ui.lua).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// The client's atlases for WoW Forever's art (C_Texture), so its pieces draw.
const BEFORE: &str = r#"C_Texture = { GetAtlasInfo = function(name)
	return { file = "atlas:" .. name, leftTexCoord = 0, rightTexCoord = 1, topTexCoord = 0, bottomTexCoord = 1, width = 32, height = 32 }
end }"#;

// What a big window's paint puts round a frame (the metal or Classic's crown hold its title bar, drag strip and
// close button), by its kit keys; shown(f): the ones on screen, comma-joined ("" when none).
const BIG: &str = r#"
local BIG_KEYS = { "frame", "metal", "crown", "dialog", "dialogArt", "dialogTile", "streaks", "drag", "closeButton" }
local function bigShown(f)
	local kit, list = f.psSkin and f.psSkin.kit or {}, {}
	for _, key in ipairs(BIG_KEYS) do
		local v = kit[key]
		local on = v ~= nil and (v.IsVisible and v:IsVisible() or (not v.IsVisible and v[1] ~= nil and v[1]:IsVisible()))
		if on then list[#list + 1] = key end
	end
	return table.concat(list, ", ")
end
"#;

const SCRIPT: &str = r#"
uistub.install()
stub.login()
stub.advance(1)
local T, GF, CT = Polestar.Theme, Polestar.UI.GuideFrame, Polestar.UI.ClassToast
local F = GF.frame
-- A card with a bottom row above the window, and a closed tab's banner ("Closed …", Reopen) on it.
uistub.openTabs({ { uistub.elwynn, 3 } }, 1)
Polestar.Fire("TAB_CLOSED", uistub.tailoring)
CT.ShowCard({ head = "ACTION BARS", title = "1 spell on your bars is an old rank", quiet = true,
	act = { label = "Upgrade", run = function() end }, later = { label = "Later" }, off = { label = "Turn these off", run = function() end } })
stub.advance(1)

-- A region's rect from its anchors, as the client lays it out (the stub keeps the anchors only).
local function rectOf(r)
	if r == nil or r == UIParent then return { l = 0, b = 0, r = UIParent:GetWidth(), t = UIParent:GetHeight() } end
	local L, R, Tp, B, cx, cy
	for _, p in ipairs(r.points) do
		local o = rectOf(p.rel or r:GetParent())
		local rp = p.relPoint
		local px = rp:find("LEFT") and o.l or rp:find("RIGHT") and o.r or (o.l + o.r) / 2
		local py = rp:find("TOP") and o.t or rp:find("BOTTOM") and o.b or (o.b + o.t) / 2
		px, py = px + p.x, py + p.y
		if p.point:find("LEFT") then L = px elseif p.point:find("RIGHT") then R = px else cx = px end
		if p.point:find("TOP") then Tp = py elseif p.point:find("BOTTOM") then B = py else cy = py end
	end
	local w, h = r:GetWidth(), r:GetHeight()
	L = L or (R and R - w) or (cx or 0) - w / 2
	R = R or L + w
	Tp = Tp or (B and B + h) or (cy or 0) + h / 2
	B = B or Tp - h
	return { l = L, r = R, t = Tp, b = B }
end
-- Draw order as the client's: strata, then frame level (a frame without its own sits one over its parent).
local STRATA = { BACKGROUND = 1, LOW = 2, MEDIUM = 3, HIGH = 4, DIALOG = 5, FULLSCREEN = 6, FULLSCREEN_DIALOG = 7, TOOLTIP = 8 }
local function strataOf(o)
	while o do
		local s = rawget(o, "strata")
		if s then return STRATA[s] or 3 end
		o = o:GetParent()
	end
	return 3
end
local function levelOf(o)
	local l = rawget(o, "level")
	if l then return l end
	local p = o:GetParent()
	return p and levelOf(p) + 1 or 0
end
local function within(o, anc)
	while o do
		if o == anc then return true end
		o = o:GetParent()
	end
	return false
end
-- Buttons take the mouse unless told otherwise; other frames when told to.
local function mouseOn(o)
	local m = rawget(o, "mouse")
	if m ~= nil then return m end
	local k = o:GetObjectType()
	return k == "Button" or k == "CheckButton"
end
local function describe(o)
	for key, v in pairs(F.psSkin and F.psSkin.kit or {}) do if v == o then return "window kit " .. key end end
	return o:GetName() or o:GetObjectType()
end
-- The shown frames that take the mouse, drawn over button b and overlapping it ("" when none).
local function over(b)
	local q, bs, bl, out = rectOf(b), strataOf(b), levelOf(b), {}
	for _, o in ipairs(stub.frames) do
		if not within(o, b) and o:IsVisible() and mouseOn(o) then
			local s, l = strataOf(o), levelOf(o)
			if s > bs or (s == bs and l > bl) then
				local r = rectOf(o)
				if r.l < q.r and r.r > q.l and r.b < q.t and r.t > q.b then out[#out + 1] = describe(o) end
			end
		end
	end
	table.sort(out)
	return table.concat(out, ", ")
end

local f = CT.frame
local out = { skin = T.SkinKey(), big = bigShown(F), shown = f:IsShown() and CT.side or false, card = {} }
-- Every button shown on the card, by its words (an icon button by its glyph's name).
for _, o in ipairs(stub.frames) do
	if o ~= f and within(o, f) and o:IsVisible() and o:GetObjectType() == "Button" then
		local label = rawget(o, "Label")
		local name = label and label:GetText() or rawget(o, "psIconName") or "?"
		out.card[name] = over(o)
	end
end
-- The banner's and the card's close buttons: the button, the kit's art on it (false: none, the glyph alone) and
-- the glyph when it shows.
local function close(b)
	local k = b.psSkin and b.psSkin.kit
	local n = k and k.closeN
	return { size = { b:GetWidth(), b:GetHeight() }, art = (n and n:IsShown() and n:GetAlpha() > 0) and n:GetWidth() or false,
		glyph = b.Icon:GetAlpha() > 0 and b.Icon:GetWidth() or false }
end
local B = GF.parts.banner
out.banner = B:IsShown() and B.psKind or false
out.closes = { card = close(f.Close), banner = close(B.Close) }
emit(out)
"#;

/// The guide window built at login with `look` saved, a card above it.
fn login(look: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: BEFORE.into(),
		addons: vec![Addon::files("Polestar", &FILES)],
		saved: vec![("Polestar".to_string(), format!("PolestarDB = {{ schema = 1, welcomeSeen = 1, settings = {{ ui = {{ skin = \"{look}\" }} }} }}"))],
		script: format!("{BIG}\n{SCRIPT}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_game_look_saved_at_login_draws_the_guide_window_s_own_frame_and_the_card_above_it_takes_every_click_1802() {
	for look in ["forever", "blizzard", "classic"] {
		let out = login(look);
		assert_eq!(out["skin"], look, "{look}: the saved look drawn from the start");
		assert_eq!(out["big"], "", "{look}: no big window's title bar, drag strip or frame on the guide window");
		assert_eq!(out["shown"], "above", "{look}: the card sits above the window");
		let card = out["card"].as_object().unwrap();
		for button in ["Upgrade", "Later", "Turn these off", "close"] {
			assert!(card.contains_key(button), "{look}: the card shows {button}: {card:?}");
		}
		for (button, covers) in card {
			assert_eq!(covers, "", "{look}: nothing that takes the mouse lies over the card's {button}");
		}
	}
}

#[test]
fn in_the_game_s_looks_the_banner_s_close_is_drawn_as_the_card_s() {
	for look in ["forever", "blizzard", "classic"] {
		let out = login(look);
		assert_eq!(out["banner"], "closedTab", "{look}: the closed tab's banner shows");
		let closes = &out["closes"];
		assert_eq!(closes["banner"], closes["card"], "{look}: the banner's close at the card's size, with the card's art and glyph");
	}
}

#[test]
fn polestar_s_own_look_keeps_the_banner_s_24_unit_close_and_its_glyph() {
	let out = login("polestar");
	assert_eq!(out["big"], "");
	assert_eq!(out["banner"], "closedTab");
	assert_eq!(out["closes"]["banner"], json!({ "size": [24, 24], "art": false, "glyph": 12 }));
	for (button, covers) in out["card"].as_object().unwrap() {
		assert_eq!(covers, "", "nothing over the card's {button}");
	}
}

// Polestar_Looks/GameSkins.lua: the guide window's paint takes away whatever a big window's paint left on the
// frame. The guide window painted once as a big window (as the login did, before the window was marked), then as
// itself in the same look, keeps none of it.
#[test]
fn the_guide_window_s_paint_takes_away_a_big_window_s_title_bar_and_drag_strip() {
	for look in ["forever", "blizzard", "classic"] {
		let out = emitted(&RunAddon {
			stubs: vec!["stub_ui.lua"],
			before: BEFORE.into(),
			addons: vec![Addon::files("Polestar", &FILES)],
			script: format!(
				r#"{BIG}
				uistub.install()
				stub.login()
				local T, F = Polestar.Theme, Polestar.UI.GuideFrame.frame
				Polestar.Set("ui.skin", "{look}")
				F.psGuide = nil
				T.Repaint(F)
				local big = bigShown(F)
				F.psGuide = true
				T.Repaint(F)
				emit({{ big = big, guide = bigShown(F) }})"#
			),
			..Default::default()
		})
		.remove(0);
		assert_ne!(out["big"], "", "{look}: painted as a big window, its frame shows");
		assert_eq!(out["guide"], "", "{look}: none of it once painted as the guide window");
	}
}

// The same class in the settings window: the Guide window page's preview of the window and its presets' pictures
// are painted as the guide window. Unmarked, a preset's picture wore a big window's metal, title bar and drag strip.
#[test]
fn the_settings_window_s_guide_window_pictures_wear_no_big_window_frame_in_the_game_s_looks() {
	for look in ["forever", "blizzard", "classic"] {
		let out = emitted(&RunAddon {
			stubs: vec!["stub_ui.lua"],
			before: BEFORE.into(),
			addons: vec![Addon::files("Polestar", &FILES)],
			script: format!(
				r#"{BIG}
				uistub.install()
				stub.login()
				Polestar.Set("ui.skin", "{look}")
				Polestar.UI.ShowOptions("guidewindow")
				stub.advance(1)
				local O = PolestarOptions
				local function within(o, anc)
					while o do
						if o == anc then return true end
						o = o:GetParent()
					end
					return false
				end
				-- Every frame inside the settings window painted as a window, and the big window pieces on any.
				local windows, inside = 0, {{}}
				for _, f in ipairs(stub.frames) do
					if f ~= O and within(f, O) and f:IsVisible() and f.psSkin and f.psSkin.kit then
						if rawget(f, "psGuide") then windows = windows + 1 end
						local big = bigShown(f)
						if big ~= "" then inside[#inside + 1] = big end
					end
				end
				emit({{ own = bigShown(O), windows = windows, inside = table.concat(inside, "; ") }})"#
			),
			..Default::default()
		})
		.remove(0);
		assert_ne!(out["own"], "", "{look}: the settings window wears its own big window frame");
		assert!(out["windows"].as_u64().unwrap() >= 1, "{look}: the page shows the guide window's pictures: {}", out["windows"]);
		assert_eq!(out["inside"], "", "{look}: nothing inside it wears a big window's frame");
	}
}
