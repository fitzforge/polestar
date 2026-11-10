//! The "Polestar" button in the game menu (addon/Polestar/UI/GameMenu.lua, setting ui.gameMenuButton, on by
//! default): it shows with the menu, opens the guide menu, closes the game menu, and touches nothing of
//! Blizzard's. The menu here is the classic one (no InitButtons/AddButton): GameMenuFrame with its secure
//! buttons, made by the client (the test's `before`), each layout method of the menu and its buttons
//! recording a call made from addon code, the way the client blocks or taints one.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

/// The client's game menu, made before the addon loads.
const MENU: &str = r#"
GameMenuFrame = CreateFrame("Frame", "GameMenuFrame", UIParent)
GameMenuFrame:SetSize(195, 248)
GameMenuFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
GameMenuFrame:Hide()
local names = { "GameMenuButtonHelp", "GameMenuButtonOptions", "GameMenuButtonKeybindings", "GameMenuButtonMacros", "GameMenuButtonLogout", "GameMenuButtonQuit", "GameMenuButtonContinue" }
local prev
for _, n in ipairs(names) do
	local b = CreateFrame("Button", n, GameMenuFrame)
	b:SetSize(144, 21)
	if prev then b:SetPoint("TOP", prev, "BOTTOM", 0, -1) else b:SetPoint("TOP", GameMenuFrame, "TOP", 0, -37) end
	_G[n], prev = b, b
end
-- Layout from addon code on the menu or its secure buttons: the client would block it or taint the menu.
stub.menuTouched = {}
local function fromAddon()
	local level = 3
	while true do
		local info = debug.getinfo(level, "S")
		if not info then return false end
		if stub.addonSources[info.source] then return true end
		level = level + 1
	end
end
local function guardFrame(f, label)
	for _, m in ipairs({ "SetPoint", "ClearAllPoints", "SetSize", "SetWidth", "SetHeight", "SetScale", "SetAllPoints", "SetParent" }) do
		local orig = f[m]
		f[m] = function(self, ...)
			if fromAddon() then table.insert(stub.menuTouched, label .. ":" .. m) end
			return orig(self, ...)
		end
	end
end
guardFrame(GameMenuFrame, "GameMenuFrame")
for _, n in ipairs(names) do guardFrame(_G[n], n) end
stub.menuKeys = function()
	local out = {}
	for k in pairs(GameMenuFrame) do out[#out + 1] = tostring(k) end
	table.sort(out)
	return table.concat(out, ",")
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: MENU.into(),
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!("uistub.install()\nstub.login()\n{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn the_game_menu_shows_a_polestar_button_that_opens_the_guide_menu_and_closes_the_game_menu_touching_none_of_blizzards_frames() {
	let out = run(r#"
		local keys = stub.menuKeys()
		local function layout()
			local out = {}
			for _, n in ipairs({ "GameMenuButtonHelp", "GameMenuButtonContinue" }) do
				local b = _G[n]
				out[#out + 1] = { n, b:GetWidth(), b:GetHeight(), select(2, b:GetPoint(1)) == nil }
			end
			return out
		end
		local before = { size = { GameMenuFrame:GetWidth(), GameMenuFrame:GetHeight() }, layout = layout() }
		local P = Polestar.UI.Picker
		local pickerBefore = P.frame ~= nil and P.frame:IsShown() or false
		GameMenuFrame:Show()
		local b = PolestarGameMenuButton
		local shown = b ~= nil and b:IsVisible() or false
		local point = { b:GetPoint(1) }
		local anchor = { point[1], point[2] == GameMenuFrame, point[3] }
		GameMenuFrame:Hide()
		local hidden = b:IsVisible()
		GameMenuFrame:Show()
		-- In combat too: nothing it does is protected.
		stub.inCombat = true
		b:Click()
		stub.inCombat = false
		local after = { size = { GameMenuFrame:GetWidth(), GameMenuFrame:GetHeight() }, layout = layout() }
		emit({ shown = shown, text = b:GetText(), parent = b:GetParent() == GameMenuFrame, anchor = anchor, hiddenWithMenu = hidden,
			menuOpen = GameMenuFrame:IsShown(), picker = { pickerBefore, P.frame ~= nil and P.frame:IsShown() },
			touched = table.concat(stub.menuTouched, " "), underGame = table.concat(stub.underGameFrames, " "), keys = keys == stub.menuKeys(), same = before.size[1] == after.size[1] and before.size[2] == after.size[2],
			layout = { before.layout, after.layout } })"#);
	assert_eq!(out["shown"], true, "shown with the menu");
	assert_eq!(out["text"], "Polestar");
	assert_eq!(out["parent"], true, "under the menu, so it hides with it");
	assert_eq!(out["anchor"], json!(["TOP", true, "BOTTOM"]), "below the menu's bottom edge");
	assert_eq!(out["hiddenWithMenu"], false);
	assert_eq!(out["menuOpen"], false, "the click closes the game menu");
	assert_eq!(out["picker"], json!([false, true]), "and opens the guide menu");
	assert_eq!(out["touched"], "", "no layout call from addon code on the menu or its buttons");
	assert_eq!(out["underGame"], "", "no frame made by addon code under a game frame");
	assert_eq!(out["keys"], true, "nothing written into the menu's table");
	assert_eq!(out["same"], true, "the menu keeps its size");
	assert_eq!(out["layout"][0], out["layout"][1], "Blizzard's buttons keep their size and place");
}

#[test]
fn turned_off_under_appearance_the_button_goes_and_the_menu_is_blizzards_alone_turned_on_again_it_comes_back() {
	let out = run(r#"
		local on = Polestar.Get("ui.gameMenuButton")
		Polestar.Set("ui.gameMenuButton", false)
		GameMenuFrame:Show()
		local off = PolestarGameMenuButton ~= nil and PolestarGameMenuButton:IsVisible() or false
		Polestar.Set("ui.gameMenuButton", true)
		local back = PolestarGameMenuButton ~= nil and PolestarGameMenuButton:IsVisible() or false
		-- Esc: the client hides the menu; the button goes with it.
		GameMenuFrame:Hide()
		emit({ on = on, off = off, back = back, esc = PolestarGameMenuButton:IsVisible() })"#);
	assert_eq!(out, json!({ "on": true, "off": false, "back": true, "esc": false }));
}

/// Forever's menu (Blizzard_GameMenu): InitButtons fills a pool (Options, Shop | AddOns, Edit Mode, Support,
/// Macros | Log Out, Exit Game | Return to Game), the menu's vertical layout stacks every shown child by
/// layoutIndex, topPadding opening a section. `stub.layout()` gives each laid-out child its top (layoutY);
/// `top(f)` follows a TOP-to-BOTTOM anchor. Layout calls from addon code on the menu or its buttons are recorded,
/// and each pooled button's layoutIndex and topPadding are checked against what the menu set.
const FOREVER_MENU: &str = r#"
BLIZZARD_STORE, GAMEMENU_OPTIONS = "Shop", "Options"
-- The menu's button template (GameMenuFrameButtonTemplate < MainMenuFrameButtonTemplate < BigRedThreeSlice):
-- three red slices and a large white label.
local TEMPLATES = { GameMenuFrameButtonTemplate = true, MainMenuFrameButtonTemplate = true }
local createFrame = CreateFrame
function CreateFrame(kind, name, parent, template, ...)
	local f = createFrame(kind, name, parent, template, ...)
	if TEMPLATES[template] then
		for _, k in ipairs({ "Left", "Middle", "Right" }) do
			local t = f:CreateTexture(nil, "BACKGROUND")
			t:SetTexture("Interface\\Buttons\\128RedButton")
			t:SetAlpha(1)
			f[k] = t
		end
		local fs = f:GetFontString()
		fs:SetFont("Fonts\\FRIZQT__.TTF", 16, "")
		fs:SetTextColor(1, 1, 1, 1)
	end
	return f
end
GameMenuFrame = CreateFrame("Frame", "GameMenuFrame", UIParent)
GameMenuFrame.buttonTemplate = "GameMenuFrameButtonTemplate"
GameMenuFrame:Hide()
stub.menuTouched, stub.pooled = {}, {}
local function fromAddon()
	local level = 3
	while true do
		local info = debug.getinfo(level, "S")
		if not info then return false end
		if stub.addonSources[info.source] then return true end
		level = level + 1
	end
end
local function guardFrame(f, label)
	for _, m in ipairs({ "SetPoint", "ClearAllPoints", "SetSize", "SetWidth", "SetHeight", "SetScale", "SetParent" }) do
		local orig = f[m]
		f[m] = function(self, ...)
			if fromAddon() then table.insert(stub.menuTouched, label .. ":" .. m) end
			return orig(self, ...)
		end
	end
end
local made = {}
local active = {}
GameMenuFrame.buttonPool = { EnumerateActive = function() local i = 0 return function() i = i + 1 return active[i] end end }
function GameMenuFrame:InitButtons()
	active = {}
	local n, pad = 0, nil
	local function add(text)
		n = n + 1
		local b = made[n]
		if not b then
			b = CreateFrame("Button", nil, self, self.buttonTemplate)
			b:SetSize(200, 35)
			guardFrame(b, text)
			-- Their look is only read from addon code.
			for _, r in ipairs({ b.Left, b.Middle, b.Right, b:GetFontString() }) do
				for _, m in ipairs({ "SetAlpha", "SetTextColor", "SetFont", "SetColorTexture", "SetTexture" }) do
					local orig = r[m]
					r[m] = function(self, ...)
						if fromAddon() then table.insert(stub.menuTouched, text .. " region:" .. m) end
						return orig(self, ...)
					end
				end
			end
			made[n] = b
		end
		b:SetText(text)
		b.layoutIndex, b.topPadding = n, pad
		pad = nil
		b:Show()
		active[#active + 1] = b
		stub.pooled[text] = { n, b.topPadding or 0 }
	end
	local function section() pad = 20 end
	add("Options") add("Shop") section()
	add("AddOns") add("Edit Mode") add("Support") add("Macros") section()
	add("Log Out") add("Exit Game") section() add("Return to Game")
end
function GameMenuFrame:Layout()
	local kids = {}
	for _, c in ipairs(self.children) do
		if c:IsShown() and c.layoutIndex then kids[#kids + 1] = c end
	end
	table.sort(kids, function(a, b) return a.layoutIndex < b.layoutIndex end)
	local y = -10
	for _, c in ipairs(kids) do
		y = y - (c.topPadding or 0)
		c.layoutY = y
		y = y - c:GetHeight()
	end
end
GameMenuFrame:SetScript("OnShow", function(self) self:InitButtons() self:Layout() end)
guardFrame(GameMenuFrame, "GameMenuFrame")
-- The top of a frame: its layout place, or below the frame its TOP is anchored to.
function stub.top(f)
	local p, rel, rp, _, y = f:GetPoint(1)
	if p == "TOP" and rel and rp == "BOTTOM" then return stub.top(rel) - rel:GetHeight() + (y or 0) end
	return f.layoutY
end
-- The shown buttons, top to bottom, with the gap above each.
function stub.order()
	local list = {}
	for _, c in ipairs(GameMenuFrame.children) do
		if c:IsShown() and c.kind == "Button" and stub.top(c) then list[#list + 1] = c end
	end
	table.sort(list, function(a, b) return stub.top(a) > stub.top(b) end)
	local out, prevBottom = {}, nil
	for _, c in ipairs(list) do
		local gap = prevBottom and math.floor(prevBottom - stub.top(c) + 0.5) or 0
		out[#out + 1] = c:GetText() .. (gap > 0 and (" +" .. gap) or (gap < 0 and (" overlaps " .. -gap) or ""))
		prevBottom = stub.top(c) - c:GetHeight()
	end
	return table.concat(out, ", ")
end
function stub.pooledKept()
	for _, b in ipairs(made) do
		local want = stub.pooled[b:GetText()]
		if not want or b.layoutIndex ~= want[1] or (b.topPadding or 0) ~= want[2] then return b:GetText() end
	end
	return true
end
"#;

/// EllesmereUI's way (learnt from its API, not its code): its button below Shop, the menu's pooled buttons below
/// Shop moved down by its height, not in combat.
const ELLESMERE_LIKE: &str = r#"
local eui = CreateFrame("Button", "EllesmereUI_GameMenuButton", GameMenuFrame)
eui:SetSize(200, 35)
eui:SetText("EllesmereUI")
eui:Hide()
hooksecurefunc(GameMenuFrame, "Layout", function(self)
	if InCombatLockdown() then eui:Hide() return end
	local shop
	for b in self.buttonPool:EnumerateActive() do if b:GetText() == "Shop" then shop = b end end
	eui:Show()
	eui:ClearAllPoints()
	eui:SetPoint("TOP", shop, "BOTTOM", 0, -12)
	for b in self.buttonPool:EnumerateActive() do
		if b.layoutIndex > shop.layoutIndex then b.layoutY = b.layoutY - 40 end
	end
end)
"#;

fn run_forever(ellesmere: bool, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: format!("{FOREVER_MENU}\n{}", if ellesmere { ELLESMERE_LIKE } else { "" }),
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!("uistub.install()\nstub.login()\n{script}"),
		..Default::default()
	})
	.remove(0)
}

const OPEN: &str = r#"
GameMenuFrame:Show()
local order = stub.order()
local P = Polestar.UI.Picker
stub.inCombat = true
GameMenuFrame:Hide() GameMenuFrame:Show()
local combat = stub.order()
PolestarGameMenuButton:Click()
stub.inCombat = false
emit({ order = order, combat = combat, closed = not GameMenuFrame:IsShown(), picker = P.frame ~= nil and P.frame:IsShown(),
	touched = table.concat(stub.menuTouched, " "), under = table.concat(stub.underGameFrames, " "), kept = stub.pooledKept() })
"#;

// Fitz in game, 2026-11-09: the button sat under "Return to Game". On Forever's menu it is a small section of its
// own after Shop, in combat too, and the click opens the guide menu; no Blizzard button is touched.
#[test]
fn on_forevers_menu_polestar_is_a_section_of_its_own_right_after_shop_in_combat_too() {
	let out = run_forever(false, OPEN);
	let order = "Options, Shop, Polestar +20, AddOns +20, Edit Mode, Support, Macros, Log Out +20, Exit Game, Return to Game +20";
	assert_eq!(out["order"], order);
	assert_eq!(out["combat"], order, "the same in combat");
	assert_eq!(out["closed"], true, "the click closes the game menu");
	assert_eq!(out["picker"], true, "and opens the guide menu");
	assert_eq!(out["touched"], "", "no layout call from addon code on the menu or its buttons");
	assert_eq!(out["under"], "", "no frame made by addon code under a game frame");
	assert_eq!(out["kept"], true, "the menu's buttons keep the layoutIndex and topPadding it gave them");
}

// With EllesmereUI's button under Shop, Polestar's comes right under it (in the same section, the gap below as
// EllesmereUI leaves under its own); in combat, when
// EllesmereUI hides its button, Polestar's is the section after Shop again.
#[test]
fn with_ellesmereui_polestar_comes_right_under_its_button_and_after_shop_in_combat_when_it_hides() {
	let out = run_forever(true, OPEN);
	assert_eq!(out["order"], "Options, Shop, EllesmereUI +12, Polestar +4, AddOns +13, Edit Mode, Support, Macros, Log Out +20, Exit Game, Return to Game +20");
	assert_eq!(out["combat"], "Options, Shop, Polestar +20, AddOns +20, Edit Mode, Support, Macros, Log Out +20, Exit Game, Return to Game +20");
	assert_eq!(out["touched"], "");
	assert_eq!(out["under"], "");
	assert_eq!(out["kept"], true);
}

#[test]
fn on_forevers_menu_turned_off_there_is_no_button_and_no_gap() {
	let out = run_forever(
		true,
		r#"
Polestar.Set("ui.gameMenuButton", false)
GameMenuFrame:Show()
local off = stub.order()
GameMenuFrame:Hide()
Polestar.Set("ui.gameMenuButton", true)
GameMenuFrame:Show()
emit({ off = off, on = stub.order() })"#,
	);
	assert_eq!(out["off"], "Options, Shop, EllesmereUI +12, AddOns +13, Edit Mode, Support, Macros, Log Out +20, Exit Game, Return to Game +20", "EllesmereUI's own gap, as without Polestar");
	assert_eq!(out["on"], "Options, Shop, EllesmereUI +12, Polestar +4, AddOns +13, Edit Mode, Support, Macros, Log Out +20, Exit Game, Return to Game +20");
}

/// EllesmereUI's menu skin, as its API shows (learnt, not copied): after InitButtons each pooled button's
/// textures go to alpha 0, a 2px inset with a dark background (EllesmereUIDB.popupMenuButtonBackgroundColor) and a
/// border (EllesmereUI._applyBlizzardConfiguredBorder) goes behind the label, whose font is its own two points
/// smaller. Its own EllesmereUI button gets the same.
const ELLESMERE_SKIN: &str = r#"
EllesmereUIDB = { popupMenuButtonBackgroundColor = { r = 0.05, g = 0.06, b = 0.07, a = 0.9 } }
EllesmereUI = { bordered = {} }
function EllesmereUI._applyBlizzardConfiguredBorder(frame, kind, size) table.insert(EllesmereUI.bordered, { frame = frame, kind = kind, size = size }) end
local function skin(b)
	if b.euiSkinned then return end
	b.euiSkinned = true
	for _, r in ipairs({ b:GetRegions() }) do
		if r:IsObjectType("Texture") then r:SetAlpha(0) end
	end
	local inset = CreateFrame("Frame", nil, b)
	inset:SetPoint("TOPLEFT", b, "TOPLEFT", 2, -2)
	inset:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -2, 2)
	local bg = inset:CreateTexture(nil, "BACKGROUND", nil, -6)
	local c = EllesmereUIDB.popupMenuButtonBackgroundColor
	bg:SetColorTexture(c.r, c.g, c.b, c.a)
	EllesmereUI._applyBlizzardConfiguredBorder(inset, "popupMenuButton", 1)
	local fs = b:GetFontString()
	local _, size, flags = fs:GetFont()
	fs:SetFont("Interface\\AddOns\\EllesmereUI\\media\\fonts\\Expressway.ttf", size - 2, flags)
end
hooksecurefunc(GameMenuFrame, "InitButtons", function(menu)
	for b in menu.buttonPool:EnumerateActive() do skin(b) end
	if EllesmereUI_GameMenuButton then skin(EllesmereUI_GameMenuButton) end
end)
"#;

fn run_look(before: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: format!("{FOREVER_MENU}\n{before}"),
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!("uistub.install()\nstub.login()\n{script}"),
		..Default::default()
	})
	.remove(0)
}

/// A button's look, as a render would show it: the template slices' alpha, the label's font and colour, and the
/// flat inset (background colour, border) when there is one.
const LOOK: &str = r#"
local function round(x) return math.floor(x * 100 + 0.5) / 100 end
local function lookOf(b)
	local slices = {}
	for _, k in ipairs({ "Left", "Middle", "Right" }) do slices[#slices + 1] = b[k] and b[k]:GetAlpha() or "none" end
	local fs = b:GetFontString()
	local path, size = fs:GetFont()
	local r, g, bl = fs:GetTextColor()
	local inset
	for _, c in ipairs(b.children) do
		if c:IsShown() and c.kind == "Frame" then
			for _, t in ipairs(c.regions) do
				if t.color and t.layer == "BACKGROUND" then inset = { round(t.color[1]), round(t.color[2]), round(t.color[3]), round(t.color[4]) } end
			end
			local bordered = false
			for _, e in ipairs(EllesmereUI and EllesmereUI.bordered or {}) do if e.frame == c then bordered = e.kind end end
			if inset then inset = { bg = inset, border = bordered } break end
		end
	end
	return { template = b.template, slices = table.concat(slices, " "), font = path:match("[^\\]+$") .. " " .. size, color = { r, g, bl }, inset = inset or false,
		size = { b:GetWidth(), b:GetHeight() } }
end
GameMenuFrame:Show()
local shop
for b in GameMenuFrame.buttonPool:EnumerateActive() do if b:GetText() == "Shop" then shop = b end end
local open = { polestar = lookOf(PolestarGameMenuButton), shop = lookOf(shop) }
stub.inCombat = true
GameMenuFrame:Hide() GameMenuFrame:Show()
local combat = lookOf(PolestarGameMenuButton)
stub.inCombat = false
emit({ open = open, combat = combat, touched = table.concat(stub.menuTouched, " "), under = table.concat(stub.underGameFrames, " "), kept = stub.pooledKept() })
"#;

// Fitz in game (0.3.6 with EllesmereUI): ours was a big red panel button among EllesmereUI's flat dark ones. Without
// a skin it is built from the menu's own button template and looks as the client's buttons do (the same slices,
// label and size as Shop).
#[test]
fn without_a_skin_the_button_is_the_menus_own_template_and_looks_like_shop() {
	let out = run_look("", LOOK);
	let (p, shop) = (&out["open"]["polestar"], &out["open"]["shop"]);
	assert_eq!(p["template"], "GameMenuFrameButtonTemplate", "the menu's buttonTemplate");
	assert_eq!(p["slices"], "1 1 1");
	assert_eq!(p["font"], shop["font"]);
	assert_eq!(p["color"], shop["color"]);
	assert_eq!(p["inset"], false, "no flat inset of ours");
	assert_eq!(p["size"], shop["size"]);
	assert_eq!(out["touched"], "", "nothing of the menu's is laid out or restyled from addon code");
	assert_eq!(out["kept"], true);
}

// With EllesmereUI's skin, ours mirrors the skinned Shop: slices hidden, EllesmereUI's font, a flat inset in its
// background colour with its border (its own border function on our frame), the same size; in combat too. The menu's
// buttons are only read.
#[test]
fn with_ellesmereuis_skin_the_button_mirrors_its_neighbours_flat_dark_look_in_combat_too() {
	let out = run_look(&format!("{ELLESMERE_LIKE}\n{ELLESMERE_SKIN}"), LOOK);
	let (p, shop) = (&out["open"]["polestar"], &out["open"]["shop"]);
	eprintln!("render: polestar {p}\nrender: shop {shop}");
	assert_eq!(shop["slices"], "0 0 0", "the stub skinned Shop");
	assert_eq!(p["slices"], "0 0 0", "our red slices hidden as Shop's are");
	assert_eq!(p["font"], "Expressway.ttf 14");
	assert_eq!(p["font"], shop["font"]);
	assert_eq!(p["color"], shop["color"]);
	assert_eq!(p["inset"], json!({ "bg": [0.05, 0.06, 0.07, 0.9], "border": "popupMenuButton" }));
	assert_eq!(p["inset"], shop["inset"], "the same inset as Shop's");
	assert_eq!(p["size"], shop["size"]);
	assert_eq!(out["combat"], *p, "the same look in combat");
	assert_eq!(out["touched"], "", "nothing of the menu's is laid out or restyled from addon code");
	assert_eq!(out["under"], "");
	assert_eq!(out["kept"], true);
}
