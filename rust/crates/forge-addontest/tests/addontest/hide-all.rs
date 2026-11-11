//! Hiding Polestar (the minimap button's click, the addon compartment, the POLESTAR_HIDE binding, /polestar
//! hide): one state per character (PolestarCharDB.hidden) under which nothing of Polestar shows and its sounds
//! are silent while the engine runs on; "Keep the arrow when hidden" (PolestarCharDB.hideKeepsArrow) leaves the
//! arrow, its travel button and its arrival chime. docs/ARCHITECTURE.md, "Hiding Polestar".
//!
//! The runtime tests load the whole addon on the stub world with two pieces of the client the stub leaves out
//! by default: the OnShow / OnHide cascade when a parent shows or hides (stub.cascadeVisibility), and combat
//! lockdown on protected frames (a secure frame, a frame holding one, or a frame one is anchored to), which
//! raises on any change to them in combat. Every frame addon code makes is recorded with its file and line, so
//! "nothing draws" is checked over every frame, not a list kept by hand. The static tests are the registry:
//! every frame Polestar makes on the game's UI, every sound it plays and every entry it adds to the game's
//! menus is listed here with how it goes when Polestar hides; a new one fails until it does.

use std::collections::BTreeMap;
use std::path::{Path, PathBuf};

use forge_addontest::run::addons_dir;
use forge_addontest::{emitted, is_match, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 1415, left = 1535.4166, right = -1941.6666, top = 1300.0, bottom = -1060.4166 })
w.moveTo(1429, 40, 60)
"#;

// The client's combat lockdown, and who made each frame (made[frame] = "Polestar/<file>:<line>": the addon
// line that called CreateFrame or Polestar.CreateFrameUnder).
const CLIENT: &str = r#"
made = {}
local secure = {}
local create = CreateFrame
function CreateFrame(kind, name, parent, template, ...)
	local f = create(kind, name, parent, template, ...)
	if type(template) == "string" and template:find("Secure") then
		f.secure = true
		secure[#secure + 1] = f
	end
	for level = 2, 12 do
		local info = debug.getinfo(level, "Sl")
		if not info then break end
		if stub.addonSources[info.source] and not (info.source:find("Core/Init.lua", 1, true) and info.currentline < 320) then
			made[f] = info.source:match("addon/(.*)$") .. ":" .. info.currentline
			break
		end
	end
	return f
end
local function under(f, root)
	while f do
		if f == root then return true end
		f = f.parent
	end
	return false
end
local function protected(f)
	for _, s in ipairs(secure) do
		if under(s, f) then return true end
		for _, p in ipairs(s.points) do
			if type(p.rel) == "table" and under(p.rel, f) then return true end
		end
	end
	return false
end
stub.blocked = {}
for _, name in ipairs({ "Show", "Hide", "SetPoint", "ClearAllPoints", "SetAllPoints", "SetParent", "SetAttribute", "SetScale", "SetSize", "SetWidth", "SetHeight" }) do
	local original = stub.Methods[name]
	stub.Methods[name] = function(self, ...)
		if stub.inCombat and protected(self) then
			stub.blocked[#stub.blocked + 1] = tostring(self.name or made[self]) .. ":" .. name
			error("ADDON_ACTION_BLOCKED " .. tostring(self.name) .. ":" .. name, 2)
		end
		return original(self, ...)
	end
end
-- As the client: PLAYER_REGEN_DISABLED comes before the lockdown, PLAYER_REGEN_ENABLED after it.
function fight(on)
	if on then
		stub.fire("PLAYER_REGEN_DISABLED")
		stub.inCombat = true
	else
		stub.inCombat = false
		stub.fire("PLAYER_REGEN_ENABLED")
	end
end
-- The tickers that ran while Polestar was hidden, by the addon line that made them.
tickedHidden = {}
local newTicker = C_Timer.NewTicker
function C_Timer.NewTicker(seconds, fn, n)
	local site = "?"
	for level = 2, 8 do
		local info = debug.getinfo(level, "Sl")
		if info and stub.addonSources[info.source] and not info.source:find("Core/Init.lua", 1, true) then
			site = info.source:match("addon/(.*)$"):match("^[^:]+")
			break
		end
	end
	return newTicker(seconds, function(...)
		if Polestar.Hidden() then tickedHidden[site] = true end
		return fn(...)
	end, n)
end
"#;

const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/hide", pack = "test", title = "Hide", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Camp", goals = {
			{ t = "goto", map = 1429, x = 45, y = 45, r = 10, label = "Camp" },
			{ t = "kill", target = "Wolf", quest = 7001, oi = 1 },
			{ t = "accept", quest = 7001, title = "Wolves", npc = 1, npcName = "Giver", map = 1429, x = 50, y = 50 },
		} },
		{ title = "Next", goals = { { t = "accept", quest = 7002, title = "More", npc = 2, npcName = "Other", map = 1429, x = 70, y = 70 } } },
	},
})
"#;

const SETUP: &str = r#"
stub.cascadeVisibility = true
stub.login(); stub.fire("QUEST_LOG_UPDATE"); stub.advance(1.1)
P = Polestar
P.Engine.SetGuide("test/hide"); stub.advance(1.1)
-- The frames addon code made that draw now: shown on screen, a region of their own showing.
function drawing()
	local out = {}
	for _, f in ipairs(stub.frames) do
		if made[f] and f:IsVisible() then
			for _, r in ipairs(f.regions) do
				if r.shown then out[#out + 1] = f; break end
			end
		end
	end
	return out
end
-- The creation sites of a list of frames, each once, sorted.
function sites(list)
	local seen, out = {}, {}
	for _, f in ipairs(list) do
		local s = made[f]
		if s and not seen[s] then seen[s] = true; out[#out + 1] = s end
	end
	table.sort(out)
	return out
end
function within(f, root)
	while f do
		if f == root then return true end
		f = f.parent
	end
	return false
end
"#;

fn run(saved: Option<&str>, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{CLIENT}"),
		addons: vec![Addon::name("Polestar")],
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{GUIDE}\n{SETUP}\n{script}"),
		..Default::default()
	})
}

fn strings(v: &Value) -> Vec<String> {
	v.as_array().map(|a| a.iter().map(|s| s.as_str().unwrap_or("").to_string()).collect()).unwrap_or_default()
}

#[test]
fn hiding_polestar_hides_every_surface_and_showing_it_brings_each_back_as_it_was() {
	let out = run(
		None,
		r#"
		-- Something of everything: the guide window and its target button, the arrow, a minimap pin and the route
		-- line, the minimap coordinates, the world map open with its pins, line and info bar, the floating button,
		-- a window the player opened (Options), one they closed (the welcome), a rare alert and a notice.
		P.Set("maps.minimapCoords", true)
		P.Set("maps.coords", true)
		P.Set("ui.launcher", true)
		WorldMapFrame:Show()
		if PolestarWelcome then PolestarWelcome:Hide() end
		P.UI.ShowOptions()
		P.Rares.ShowSample()
		P.Nav.alerts.ShowNotice("Notice", "A line", 12)
		stub.advance(0.5)
		local toasts = { PolestarRareToast, PolestarAlert }
		local function toast(f)
			for _, t in ipairs(toasts) do if within(f, t) then return true end end
			return false
		end
		local before = {}
		for _, f in ipairs(stub.frames) do
			if made[f] and not toast(f) then before[f] = f:IsVisible() end
		end
		local shown = sites(drawing())
		P.SetHidden(true)
		stub.advance(2)
		local hidden = sites(drawing())
		local ticking = {}
		for _, f in ipairs(stub.frames) do
			if made[f] and f.scripts.OnUpdate and f:IsVisible() then ticking[#ticking + 1] = f end
		end
		local ticked = {}
		for site in pairs(tickedHidden) do ticked[#ticked + 1] = site end
		table.sort(ticked)
		P.SetHidden(false)
		stub.advance(2)
		local changed = {}
		for f, was in pairs(before) do
			if f:IsVisible() ~= was then changed[#changed + 1] = f end
		end
		emit({
			shown = #shown, hidden = hidden, ticking = sites(ticking), ticked = ticked, changed = sites(changed),
			options = PolestarOptions:IsVisible(), welcome = PolestarWelcome ~= nil and PolestarWelcome:IsVisible(),
			guide = PolestarGuideFrame:IsVisible(), arrow = PolestarNavArrow:IsVisible(), target = PolestarTargetButton:IsShown(),
			toasts = { PolestarRareToast:IsShown(), PolestarAlert:IsShown() },
		})"#,
	)
	.remove(0);
	assert!(out["shown"].as_u64().unwrap() > 10, "the scene draws a good part of Polestar: {out}");
	for site in strings(&out["hidden"]) {
		assert!(is_match(&site, r"^Polestar/(Maps/MinimapButton|UI/Launcher)\.lua:"), "{site} still draws while Polestar is hidden: {out}");
	}
	assert!(strings(&out["hidden"]).iter().any(|s| s.starts_with("Polestar/Maps/MinimapButton.lua")), "the minimap button stays: {out}");
	assert!(strings(&out["hidden"]).iter().any(|s| s.starts_with("Polestar/UI/Launcher.lua")), "the floating button stays: {out}");
	assert!(strings(&out["ticking"]).is_empty() && out["ticking"].as_object().is_none_or(|o| o.is_empty()), "no frame of Polestar's runs an OnUpdate while it is hidden: {out}");
	// What may tick while hidden: the engine's arrival poll, Nav's once-a-second tick (the travel planner and the
	// walking engine) and the transports' sampler; nothing that draws.
	for site in strings(&out["ticked"]) {
		assert!(["Polestar/Core/Engine.lua", "Polestar/Nav/Nav.lua", "Polestar/Nav/Transit.lua"].contains(&site.as_str()), "{site} ticks while Polestar is hidden");
	}
	assert!(strings(&out["changed"]).is_empty() && out["changed"].as_object().is_none_or(|o| o.is_empty()), "every frame is back as it was: {out}");
	assert_eq!(out["options"], true, "the window the player opened is open again");
	assert_eq!(out["welcome"], false, "the one they closed stays closed");
	assert_eq!((out["guide"].clone(), out["arrow"].clone(), out["target"].clone()), (json!(true), json!(true), json!(true)));
	assert_eq!(out["toasts"], json!([false, false]), "the alerts up as Polestar hid are not kept for after");
}

#[test]
fn a_hidden_polestar_stays_hidden_after_a_reload_and_its_buttons_look_off() {
	let out = run(
		Some(r#"PolestarCharDB = { schema = 1, hidden = true }"#),
		r#"
		local b = PolestarMinimapButton
		local function look() return { P.Hidden(), P.UIParent:IsShown(), PolestarGuideFrame:IsVisible(), PolestarNavArrow:IsShown(),
			b.Icon.desaturated == true, b.Icon:GetAlpha() < 1, P.CharState().hidden == true } end
		emit(look())
		P.ToggleHidden()
		emit(look())
		P.ToggleHidden()
		emit(look())"#,
	);
	assert_eq!(out[0], json!([true, false, false, false, true, true, true]), "hidden from the start: no flash of Polestar, the button greyed");
	assert_eq!(out[1], json!([false, true, true, true, false, false, false]));
	assert_eq!(out[2], json!([true, false, false, false, true, true, true]), "and saved again for the next reload");
}

#[test]
fn in_a_fight_hiding_takes_the_rest_at_once_and_the_secure_buttons_when_it_ends_with_nothing_blocked() {
	let out = run(
		None,
		r#"
		local function look()
			return { PolestarGuideFrame:IsVisible(), PolestarNavArrow:IsVisible(), PolestarTargetButton:IsShown(), #stub.blocked }
		end
		emit(look())
		fight(true)
		P.SetHidden(true); stub.advance(0.5)
		emit(look())
		fight(false); stub.advance(0.5)
		emit(look())
		fight(true)
		P.SetHidden(false); stub.advance(0.5)
		emit(look())
		fight(false); stub.advance(0.5)
		emit(look())"#,
	);
	assert_eq!(
		out,
		vec![json!([true, true, true, 0]), json!([false, false, true, 0]), json!([false, false, false, 0]), json!([true, true, false, 0]), json!([true, true, true, 0])],
		"window and arrow at once; the target button (secure) once the fight ends, both ways; no protected call"
	);
}

#[test]
fn the_minimap_button_the_compartment_the_key_and_polestar_hide_each_toggle_it() {
	let out = run(
		None,
		r#"
		local b = PolestarMinimapButton
		local seen = {}
		local function note() seen[#seen + 1] = P.Hidden() end
		b:GetScript("OnClick")(b, "LeftButton"); note()
		b:GetScript("OnClick")(b, "LeftButton"); note()
		Polestar_OnAddonCompartmentClick("Polestar", "LeftButton"); note()
		Polestar_OnAddonCompartmentClick("Polestar", "LeftButton"); note()
		P.Bindings.Hide(); note()
		P.Bindings.Hide(); note()
		local said = #stub.messages
		SlashCmdList.POLESTAR("hide"); note()
		local told = stub.messages[said + 1] or ""
		SlashCmdList.POLESTAR("hide"); note()
		-- The tooltip says what a click does now.
		P.SetHidden(true)
		b:GetScript("OnEnter")(b)
		local tip = GameTooltip.lines[2]
		P.SetHidden(false)
		b:GetScript("OnEnter")(b)
		emit({ seen = seen, told = told, hiddenTip = tip, shownTip = GameTooltip.lines[2], label = BINDING_NAME_POLESTAR_HIDE })"#,
	)
	.remove(0);
	assert_eq!(out["seen"], json!([true, false, true, false, true, false, true, false]));
	assert!(is_match(out["told"].as_str().unwrap(), r"Polestar is hidden: /polestar hide or the minimap button shows it again\."), "{out}");
	assert_eq!(out["hiddenTip"], "Polestar is hidden: click to show");
	assert_eq!(out["shownTip"], "Click: hide Polestar");
	assert_eq!(out["label"], "Hide/show Polestar");
	// The key binding, in Polestar's own category of the Key Bindings, right after the window's toggle.
	let xml = std::fs::read_to_string(addons_dir().join("Polestar/Bindings.xml")).unwrap();
	assert!(
		is_match(
			&xml,
			r#"(?s)<Binding name="POLESTAR_TOGGLE"[^>]*>\s*Polestar\.Bindings\.Toggle\(\)\s*</Binding>\s*<Binding name="POLESTAR_HIDE" category="Polestar"[^>]*>\s*Polestar\.Bindings\.Hide\(\)\s*</Binding>"#
		),
		"{xml}"
	);
}

// While hidden, the guide window's toggle (its key, /polestar, the menu's Guide window) brings Polestar back
// with the window on; a command that shows something brings it back first; one that only prints does not.
#[test]
fn asking_for_the_guide_window_or_a_polestar_window_brings_polestar_back() {
	let out = run(
		None,
		r#"
		local seen = {}
		P.Set("ui.shown", false)
		P.SetHidden(true)
		P.Bindings.Toggle()
		seen[#seen + 1] = { P.Hidden(), P.Get("ui.shown") == true, PolestarGuideFrame:IsVisible() }
		P.SetHidden(true)
		SlashCmdList.POLESTAR("status")
		seen[#seen + 1] = P.Hidden()
		SlashCmdList.POLESTAR("options")
		seen[#seen + 1] = { P.Hidden(), PolestarOptions:IsVisible() }
		emit(seen)"#,
	)
	.remove(0);
	assert_eq!(out, json!([[false, true, true], true, [false, true]]));
}

#[test]
fn while_hidden_polestar_plays_no_sound_shows_no_tooltip_line_and_keeps_no_alert_for_later() {
	let out = run(
		None,
		r#"
		P.Set("behavior.whileHereSound", true)
		P.Set("rares.sound", true)
		P.Hooks.ItemLines("test", function(tooltip) P.Hooks.AddLine(tooltip, "Polestar line") end)
		local function sounds()
			local before = #stub.sounds
			P.Rares.PlaySound()
			P.UI.WhileHereToast.Chime()
			P.Nav.alerts.ShowSample()
			P.PlaySound(8959, "Master")
			P.PlaySoundFile("Sound\\Test.ogg", "Master")
			return #stub.sounds - before
		end
		-- The lines Polestar's modules add to an item's tooltip (the stub's tooltip counts no lines itself).
		local function lines()
			GameTooltip:SetOwner(UIParent, "ANCHOR_NONE")
			P.Hooks.OnItemTooltip(GameTooltip, { id = 25 })
			return #GameTooltip.lines
		end
		local seen = { shown = { sounds(), lines() } }
		P.Nav.alerts.banner:Hide()
		P.SetHidden(true)
		seen.hidden = { sounds(), lines() }
		-- News while hidden: a rare in sight, a While you're here line.
		P.Fire("RARE_SPOTTED", { kind = "rare", name = "Thuros", source = "nameplate", id = 61 })
		P.Fire("WHILE_HERE_CHANGED")
		stub.advance(1)
		P.SetHidden(false)
		stub.advance(1)
		seen.after = { PolestarRareToast ~= nil and PolestarRareToast:IsShown(), PolestarWhileHereToast ~= nil and PolestarWhileHereToast:IsShown(),
			P.Nav.alerts.banner:IsShown() }
		emit(seen)"#,
	)
	.remove(0);
	assert_eq!(out["shown"], json!([5, 1]), "five sounds and a tooltip line with Polestar shown");
	assert_eq!(out["hidden"], json!([0, 0]), "none while hidden");
	assert_eq!(out["after"], json!([false, false, false]), "no alert waits to pop up when Polestar is back");
}

// The arrow's own surfaces: the arrow, its travel button (the route's Hearthstone) and its arrival chime, on
// Nav's harness (tests/lua/stub_nav.lua, as hide-with-guide.rs).
fn run_nav(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Theme/Theme.xml", "Nav/Nav.xml"])],
		login: true,
		script: script.into(),
		..Default::default()
	})
}

#[test]
fn keep_the_arrow_when_hidden_keeps_the_arrow_its_travel_button_and_chime_and_takes_effect_at_once() {
	let out = run_nav(
		r#"
		local P, N, nav = Polestar.Nav.prompts, Polestar.Nav, stub.nav
		nav.items[6948] = 1
		local route = N.GetRoute
		N.GetRoute = function() return { { kind = "hearth" }, { kind = "walk" } }, 1 end
		local function look()
			stub.runTimers()
			return { P.Wanted() ~= nil, P.button ~= nil and P.button:IsShown(), N.arrow.frame:IsShown() }
		end
		nav.setWaypoint({ map = 9000, x = 50, y = 20, label = "Somewhere", stepIndex = 1, goalIndex = 1, kind = "goto", r = 8 })
		N.Refresh()
		emit(look())
		Polestar.SetHidden(true)
		emit(look())
		Polestar.SetHideKeepsArrow(true)
		emit({ look(), Polestar.CharState().hideKeepsArrow == true })
		Polestar.SetHideKeepsArrow(false)
		emit(look())
		Polestar.SetHidden(false)
		emit(look())
		N.GetRoute = route
		-- The chime: none from a hidden arrow, one from a kept one; every other sound stays silent.
		local function target(wx, wy) local m, x, y = nav.mapPoint(wx, wy); N.SetTarget(m, x, y, "T") end
		Polestar.SetHidden(true)
		target(20, 0); stub.advance(0.2)
		nav.place(15, 0); stub.advance(0.2)
		local quiet = #stub.sounds
		nav.place(0, 0); stub.advance(0.2)
		Polestar.SetHideKeepsArrow(true)
		stub.advance(0.2)
		nav.place(15, 0); stub.advance(0.2)
		local kept = #stub.sounds
		Polestar.PlaySound(8959, "Master")
		emit({ quiet, kept, #stub.sounds })"#,
	);
	assert_eq!(out[0], json!([true, true, true]), "the travel button and the arrow, Polestar shown");
	assert_eq!(out[1], json!([false, false, false]), "hidden: both go");
	assert_eq!(out[2], json!([[true, true, true], true]), "Keep the arrow when hidden, while hidden: both back at once, saved for the character");
	assert_eq!(out[3], json!([false, false, false]), "turned off while hidden: gone again at once");
	assert_eq!(out[4], json!([true, true, true]));
	assert_eq!(out[5], json!([0, 1, 1]), "no chime from a hidden arrow; a kept arrow chimes; other sounds stay silent");
}

// The right-click menu of the minimap and floating buttons: the guide window first, the arrow (nav.arrow, the
// one arrow setting), hiding Polestar, then right under it whether hiding keeps the arrow; then the windows,
// which bring a hidden Polestar back.
#[test]
fn the_menu_toggles_the_window_the_arrow_hiding_and_whether_hiding_keeps_the_arrow() {
	let out = run(
		None,
		r#"
		local b = PolestarMinimapButton
		local function items()
			P.Maps.ShowMenu(b)
			local out = {}
			for _, r in ipairs(PolestarMenu.rows) do
				if r:IsShown() then out[#out + 1] = (r.psItem.checked and "[x] " or "") .. r.Text:GetText() end
			end
			P.Widgets.HideMenu()
			return out
		end
		local function click(text)
			P.Maps.ShowMenu(b)
			for _, r in ipairs(PolestarMenu.rows) do
				if r:IsShown() and r.Text:GetText() == text then r:GetScript("OnClick")(r) return end
			end
			error("no menu row " .. text)
		end
		local seen = { items() }
		click("Keep the arrow when hidden")
		seen[#seen + 1] = { P.HideKeepsArrow(), P.CharState().hideKeepsArrow == true }
		click("Hide Polestar")
		seen[#seen + 1] = items()
		click("Hide arrow")
		seen[#seen + 1] = { P.Get("nav.arrow") == true, PolestarNavArrow:IsShown() }
		click("Show arrow")
		seen[#seen + 1] = { P.Get("nav.arrow") == true, PolestarNavArrow:IsShown(), P.Hidden() }
		click("Guides")
		seen[#seen + 1] = { P.Hidden(), PolestarPicker ~= nil and PolestarPicker:IsVisible() }
		emit(seen)"#,
	)
	.remove(0);
	assert_eq!(out[0], json!(["[x] Guide window", "Hide arrow", "Hide Polestar", "Keep the arrow when hidden", "Guides", "Lookup", "Options", "Report a problem"]));
	assert_eq!(out[1], json!([true, true]), "checked, and saved for the character");
	assert_eq!(out[2], json!(["Guide window", "Hide arrow", "Show Polestar", "[x] Keep the arrow when hidden", "Guides", "Lookup", "Options", "Report a problem"]));
	assert_eq!(out[3], json!([false, false]), "the arrow off (nav.arrow) while hidden and kept");
	assert_eq!(out[4], json!([true, true, true]), "and on again: the kept arrow shows, Polestar still hidden");
	assert_eq!(out[5], json!([false, true]), "a window from the menu brings Polestar back");
}

// ------------------------------------------------------------------------------------------------------------
// The registry: what Polestar puts on the game's UI, and how each goes when Polestar hides.
// ------------------------------------------------------------------------------------------------------------

// (file, parent, lines, a word the file must hold: its hidden gate, how it goes)
// Every frame made on UIParent outside Polestar's layer (Polestar.UIParent), on the minimap, or under one of the
// game's frames. Frames made on Polestar.UIParent hide with the layer, and frames under a map view's frame
// (view.frame, Nav/MapCanvas.lua) with that view: they need no listing.
const SURFACES: &[(&str, &str, usize, &str, &str)] = &[
	("Polestar/Core/Init.lua", "UIParent", 1, "applyLayer", "the layer itself: hiding is its Hide()"),
	("Polestar/Nav/Arrow.lua", "UIParent", 1, "ArrowHidden", "the arrow: hidden unless Keep the arrow when hidden is on"),
	("Polestar/Nav/Prompts.lua", "UIParent", 1, "ArrowHidden", "the travel button (secure): with the arrow, changed out of combat"),
	(
		"Polestar/QoL/Buttons.lua",
		"UIParent",
		3,
		"GuideShown",
		"the quest item, Hearthstone, target, rare and bag buttons, their holder and the step key (secure): with ns.GuideShown, changed out of combat; the step key draws nothing",
	),
	("Polestar/Rares/Toast.lua", "UIParent", 1, "POLESTAR_HIDDEN", "the rare card's secure Target button: let go of with the card"),
	("Polestar/UI/NameTargets.lua", "UIParent", 1, "POLESTAR_HIDDEN", "the guide's clickable names (secure): hidden with the window, out of combat (in a fight their driver hides them)"),
	("Polestar/Theme/Widgets.lua", "UIParent", 2, "POLESTAR_HIDDEN", "the menu and its click-catcher: the ways back open it; one open as Polestar hides closes"),
	("Polestar/UI/Launcher.lua", "UIParent", 1, "PaintHidden", "the floating button: a way back, dimmed"),
	("Polestar/UI/GameMenu.lua", "UIParent", 3, "SetHidden", "the game menu's Polestar button: a way back, in the game's own menu"),
	(
		"Polestar/UI/Gamepad.lua",
		"UIParent",
		6,
		"G.Close",
		"the gamepad's input frames, the buttons its bindings click, focus ring and hints: they follow the window holding the gamepad (the menu included)",
	),
	("Polestar/Maps/MinimapButton.lua", "Minimap", 1, "PaintHidden", "the minimap button: a way back, dimmed"),
	("Polestar/Maps/Coords.lua", "Minimap", 1, "Hidden", "the minimap coordinates: off while hidden"),
	("Polestar/Nav/Pins.lua", "Minimap", 3, "Hidden", "the minimap's pins, trail and areas: nothing drawn while hidden"),
	("Polestar/Maps/RouteLines.lua", "Minimap", 1, "Hidden", "the minimap's route line: off while hidden"),
	("Polestar/Maps/RouteLines.lua", "mm", 1, "Hidden", "its driver, under the line's frame"),
	("Polestar/Nav/MapCanvas.lua", "canvas", 1, "POLESTAR_HIDDEN", "a map's view frame, every map drawing's parent: hidden while Polestar is"),
	("Polestar/Maps/WorldMap.lua", "owner", 1, "Hidden", "the world map's info bar: off while hidden"),
	("Polestar/QoL/XPMark.lua", "bar", 1, "Hidden", "the guide level on the XP bar: off while hidden"),
	("Polestar/QoL/Rewards.lua", "button", 1, "Hidden", "the quest reward marks: off while hidden"),
	("Polestar/Talents/Overlay.lua", "button", 1, "Hidden", "the talent marks: off while hidden"),
	("Polestar/Talents/Overlay.lua", "m", 2, "Hidden", "their ring and badge, under the mark"),
	("Polestar/QoL/Trainer.lua", "ClassTrainerFrame", 1, "Hidden", "the Train All button on the trainer window: off while hidden"),
];

// Marks Polestar puts on the game's frames without a frame of their own (textures on the game's buttons,
// menu entries, nameplate icons, text it changes): each file asks Polestar.Hidden().
const MARKS: &[(&str, &str)] = &[
	("Polestar/Core/Hooks.lua", "every tooltip line of every module, and modified item clicks"),
	("Polestar/Gear/Bags.lua", "upgrade arrows on bag items"),
	("Polestar/QoL/BagGlow.lua", "the step's item glowing in the bags"),
	("Polestar/Quests/BagMarks.lua", "quest marks on bag items"),
	("Polestar/Quests/QuestLevels.lua", "quest levels before quest titles (the text put back)"),
	("Polestar/Quests/Tooltips.lua", "quest icons on nameplates"),
	("Polestar/UI/QuestieTurnIns.lua", "turn-in captions in Questie's tracker"),
	("Polestar/UI/QuestLinks.lua", "Show in Guides in the quest log's menus"),
	("Polestar/UI/GuideFrame.lua", "Pin as along the way in the quest log's menu"),
	("Polestar/Maps/Services.lua", "NPC services in the map's tracking menus"),
	("Polestar/Nav/Nearby.lua", "Nearby services in the map's tracking menus"),
	("Polestar/QoL/Flight.lua", "the flight map's mark and route"),
	("Polestar/QoL/Restock.lua", "the Restock button under the merchant window"),
	("Polestar/Nav/Bridges.lua", "the target mirrored to TomTom and the game's waypoint (with the arrow)"),
	("Polestar/Nav/Handoff.lua", "the target handed to Shortest Path Forever (with the arrow)"),
];

fn lua_files(dir: &Path) -> Vec<PathBuf> {
	let mut out = Vec::new();
	for entry in std::fs::read_dir(dir).unwrap_or_else(|e| panic!("{}: {e}", dir.display())) {
		let entry = entry.unwrap();
		let full = entry.path();
		if entry.file_type().unwrap().is_dir() {
			out.extend(lua_files(&full));
		} else if full.extension().is_some_and(|e| e == "lua") {
			out.push(full);
		}
	}
	out
}

// Polestar's own files (addon/Polestar), relative to addon/, with their code (comments dropped), line by line.
fn polestar_code() -> Vec<(String, Vec<String>)> {
	let addons = addons_dir();
	let comment = regex::Regex::new(r"(^|\s)--.*$").unwrap();
	let mut out = Vec::new();
	for file in lua_files(&addons.join("Polestar")) {
		let rel = file.strip_prefix(&addons).unwrap().components().map(|c| c.as_os_str().to_string_lossy().into_owned()).collect::<Vec<_>>().join("/");
		let src = String::from_utf8_lossy(&std::fs::read(&file).unwrap()).into_owned();
		out.push((rel, src.split('\n').map(|l| comment.replacen(l, 1, "").into_owned()).collect()));
	}
	out.sort();
	out
}

#[test]
fn every_frame_polestar_makes_on_the_game_s_ui_hides_with_polestar_and_is_listed() {
	// CreateFrame(kind, name, UIParent ...) and Polestar.CreateFrameUnder(kind, name, <parent> ...): a parent
	// that is the game's, or under it, not Polestar's layer or a map view's frame.
	let on_ui = regex::Regex::new(r#"\bCreateFrame\(\s*(?:"[^"]*"|\w+)\s*,\s*(?:"[^"]*"(?:\s*\.\.\s*\w+)?|[\w.]+|nil)\s*,\s*UIParent\b"#).unwrap();
	let under = regex::Regex::new(r#"\bCreateFrameUnder\(\s*(?:"[^"]*"|\w+)\s*,\s*(?:"[^"]*"|\w+|nil)\s*,\s*([\w.]+)"#).unwrap();
	let mut found: BTreeMap<(String, String), usize> = BTreeMap::new();
	for (file, lines) in polestar_code() {
		for line in &lines {
			if line.contains("function ns.CreateFrameUnder") {
				continue; // its definition
			}
			if on_ui.is_match(line) {
				*found.entry((file.clone(), "UIParent".into())).or_default() += 1;
			}
			if let Some(m) = under.captures(line) {
				let parent = m[1].to_string();
				if parent.ends_with(".frame") {
					continue; // a map view's frame: hides with the view
				}
				*found.entry((file.clone(), parent)).or_default() += 1;
			}
		}
	}
	let listed: BTreeMap<(String, String), usize> = SURFACES.iter().map(|(f, p, n, _, _)| ((f.to_string(), p.to_string()), *n)).collect();
	assert_eq!(found, listed, "a frame on the game's UI was added or removed: put it on Polestar.UIParent (or under a map view's frame), or make it go with Polestar.Hidden() and list it in SURFACES");
	let addons = addons_dir();
	for (file, _, _, gate, how) in SURFACES {
		let src = std::fs::read_to_string(addons.join(file)).unwrap();
		assert!(src.contains(gate), "{file} ({how}) has no {gate}");
	}
	for (file, what) in MARKS {
		let src = std::fs::read_to_string(addons.join(file)).unwrap();
		assert!(is_match(&src, r"ns\.Hidden\(\)|ns\.ArrowHidden\(\)"), "{file} ({what}) does not ask whether Polestar is hidden");
	}
}

#[test]
fn every_sound_polestar_plays_goes_through_polestar_play_sound() {
	// A direct call, or one handed to pcall.
	let call = regex::Regex::new(r"(^|[^.\w])PlaySound(File)?\s*[(,]").unwrap();
	let mut direct = Vec::new();
	for (file, lines) in polestar_code() {
		if file == "Polestar/Core/Init.lua" {
			continue; // Polestar.PlaySound / PlaySoundFile themselves
		}
		for (i, line) in lines.iter().enumerate() {
			if call.is_match(line) && !line.contains("ns.PlaySound") {
				direct.push(format!("{file}:{}", i + 1));
			}
		}
	}
	assert_eq!(direct, Vec::<String>::new(), "a sound played around Polestar.PlaySound: it would play while Polestar is hidden");
}

#[test]
fn every_entry_polestar_adds_to_the_game_s_menus_asks_whether_polestar_is_hidden() {
	for (file, lines) in polestar_code() {
		if lines.iter().any(|l| l.contains("Menu.ModifyMenu(")) {
			assert!(MARKS.iter().any(|(f, _)| *f == file), "{file} adds to a game menu: make its entries ask Polestar.Hidden() and list it in MARKS");
		}
	}
}
