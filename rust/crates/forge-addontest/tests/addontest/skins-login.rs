//! The game's looks as a login builds them (#1802): the look is in PolestarDB before ADDON_LOADED, not switched
//! to. The guide window was skinned before it was marked the guide window, so its first paint was the big windows'
//! (Theme/GameSkins.lua BIG: a "Polestar" title bar and a drag strip 500 levels over the window), which nothing took
//! away: the strip lay over the bottom row of the card above the window (Later, Turn these off; the level-up
//! spells, old ranks and update cards too). Against the real Core + Theme + UI manifests and the fake Engine
//! (tests/lua/stub_ui.lua).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// The client's atlases for WoW Forever's art (C_Texture), so its pieces draw.
const BEFORE: &str = r#"C_Texture = { GetAtlasInfo = function(name)
	return { file = "atlas:" .. name, leftTexCoord = 0, rightTexCoord = 1, topTexCoord = 0, bottomTexCoord = 1, width = 32, height = 32 }
end }"#;

const SCRIPT: &str = r#"
uistub.install()
stub.login()
stub.advance(1)
local T, GF, CT = Polestar.Theme, Polestar.UI.GuideFrame, Polestar.UI.ClassToast
local F = GF.frame
-- A card with a bottom row above the window.
uistub.openTabs({ { uistub.elwynn, 3 } }, 1)
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
local out = { skin = T.SkinKey(), card = {} }
local big = {}
for _, key in ipairs({ "frame", "metal", "dialog", "streaks", "drag", "closeButton" }) do
	local v = F.psSkin.kit and F.psSkin.kit[key]
	if v and v:IsVisible() then big[#big + 1] = key end
end
out.big = table.concat(big, ", ")
out.shown = f:IsShown() and CT.side or false
for _, key in ipairs({ "Act", "Later", "Off", "Close" }) do
	local b = f[key]
	if b:IsShown() then out.card[key] = over(b) end
end
emit(out)
"#;

/// The guide window built at login with `look` saved, a card above it.
fn login(look: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: BEFORE.into(),
		addons: vec![Addon::files("Polestar", &FILES)],
		saved: vec![("Polestar".to_string(), format!("PolestarDB = {{ schema = 1, welcomeSeen = 1, settings = {{ ui = {{ skin = \"{look}\" }} }} }}"))],
		script: SCRIPT.into(),
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
		assert_eq!(card.len(), 4, "{look}: Upgrade, Later, Turn these off and the close shown: {card:?}");
		for (button, covers) in card {
			assert_eq!(covers, "", "{look}: nothing that takes the mouse lies over the card's {button}");
		}
	}
}

// Theme/GameSkins.lua: the guide window's paint takes away whatever a big window's paint left on the frame. The
// guide window painted once as a big window (as 0.3.7's login did, before the window was marked), then as itself
// in the same look, keeps none of it.
#[test]
fn the_guide_window_s_paint_takes_away_a_big_window_s_title_bar_and_drag_strip() {
	for look in ["forever", "blizzard", "classic"] {
		let out = emitted(&RunAddon {
			stubs: vec!["stub_ui.lua"],
			before: BEFORE.into(),
			addons: vec![Addon::files("Polestar", &FILES)],
			script: format!(
				r#"uistub.install()
				stub.login()
				local T, F = Polestar.Theme, Polestar.UI.GuideFrame.frame
				Polestar.Set("ui.skin", "{look}")
				local function shown()
					local list = {{}}
					for _, key in ipairs({{ "frame", "metal", "dialog", "streaks", "drag" }}) do
						local v = F.psSkin.kit and F.psSkin.kit[key]
						if v and v:IsVisible() then list[#list + 1] = key end
					end
					return table.concat(list, ", ")
				end
				F.psGuide = nil
				T.Repaint(F)
				local big = shown()
				F.psGuide = true
				T.Repaint(F)
				emit({{ big = big, guide = shown() }})"#
			),
			..Default::default()
		})
		.remove(0);
		assert_ne!(out["big"], "", "{look}: painted as a big window, its frame shows");
		assert_eq!(out["guide"], "", "{look}: none of it once painted as the guide window");
	}
}

// The same class: the settings window's preview of the guide window (Colour & type) is painted as the guide window.
// Unmarked, it wore a big window's metal and title bar inside the preview (Classic's header plate over its tab).
#[test]
fn the_settings_window_s_preview_of_the_guide_window_wears_no_big_window_frame_in_the_game_s_looks() {
	for look in ["forever", "blizzard", "classic"] {
		let out = emitted(&RunAddon {
			stubs: vec!["stub_ui.lua"],
			before: BEFORE.into(),
			addons: vec![Addon::files("Polestar", &FILES)],
			script: format!(
				r#"uistub.install()
				stub.login()
				Polestar.Set("ui.skin", "{look}")
				Polestar.UI.ShowOptions("appearance")
				stub.advance(1)
				local O = PolestarOptions
				local function within(o, anc)
					while o do
						if o == anc then return true end
						o = o:GetParent()
					end
					return false
				end
				-- Every big window piece on a frame inside the settings window (its own frame is outside the list).
				local list = {{}}
				for _, f in ipairs(stub.frames) do
					local kit = f ~= O and within(f, O) and f:IsVisible() and f.psSkin and f.psSkin.kit
					if kit then
						for _, key in ipairs({{ "frame", "metal", "dialog", "streaks", "drag" }}) do
							if kit[key] and kit[key]:IsVisible() then list[#list + 1] = key end
						end
					end
				end
				local metal = O.psSkin.kit and O.psSkin.kit.metal
				emit({{ own = metal ~= nil and metal:IsVisible(), inside = table.concat(list, ", ") }})"#
			),
			..Default::default()
		})
		.remove(0);
		assert_eq!(out["own"], true, "{look}: the settings window wears its own big window frame");
		assert_eq!(out["inside"], "", "{look}: nothing inside it does, the guide window's preview included");
	}
}
