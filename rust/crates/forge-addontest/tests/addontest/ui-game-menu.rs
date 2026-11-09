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

#[test]
fn a_client_that_lays_the_menu_out_itself_gets_the_button_through_its_own_add_button() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: r#"
GameMenuFrame = CreateFrame("Frame", "GameMenuFrame", UIParent)
GameMenuFrame:Hide()
stub.added = {}
function GameMenuFrame:AddButton(text, fn) table.insert(stub.added, { text, fn }) end
function GameMenuFrame:InitButtons() stub.added = {} self:AddButton("Options", function() end) end
"#
		.into(),
		addons: vec![Addon::files("Polestar", &FILES)],
		script: r#"uistub.install()
stub.login()
GameMenuFrame:InitButtons()
local texts = {}
for i, a in ipairs(stub.added) do texts[i] = a[1] end
stub.added[#stub.added][2]()
local P = Polestar.UI.Picker
emit({ texts = texts, own = PolestarGameMenuButton ~= nil, picker = P.frame ~= nil and P.frame:IsShown() })"#
			.into(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out, json!({ "texts": ["Options", "Polestar"], "own": false, "picker": true }));
}
