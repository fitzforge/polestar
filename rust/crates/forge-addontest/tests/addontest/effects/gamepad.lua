-- env: ui stub_gamepad.lua
-- The Gamepad page (UI/Gamepad.lua, UI/GamepadGuide.lua): the game's gamepad on and plugged in, the keyboard and
-- mouse interface (gamepad.rs). The settings window opened and closed again, read as the gamepad sees it: who
-- holds the buttons, the hint bar, the B chip by its close button; each key binding's row binds a key, which the
-- game then runs the action for and the addon names.
local G, UI
local function options(read)
	UI.ShowOptions("gamepad")
	stub.advance(0.3)
	local out = read()
	PolestarOptions:Hide()
	stub.advance(0.1)
	return out
end
local function holds() return options(function() return { owner = G.owner == PolestarOptions, overrides = stub.overrideCount() } end) end
local function hints() return options(function() return PolestarPadHints ~= nil and PolestarPadHints:IsVisible() or false end) end
-- The B chip by the window's close button: a letter, or the PlayStation's circle.
local function chip()
	return options(function()
		local p = PolestarPadBadge and PolestarPadBadge:IsVisible() and PolestarPadBadge.parts[1]
		return p and { text = p.text:IsShown() and p.text:GetText() or false, tex = p.tex:IsShown() and p.tex:GetTexture() or false } or false
	end)
end
local MOUSE = { ["gamepad.withMouse"] = true }
-- A bound key pressed: the action the game runs for it, and the key the addon shows for the action.
local function bound(action)
	return { bind = "F9", probe = function()
		stub.press("F9")
		local ran = stub.pad.ran[#stub.pad.ran] or false
		for i = #stub.pad.ran, 1, -1 do stub.pad.ran[i] = nil end
		return { ran = ran, shown = G.KeyText(action) or false }
	end }
end
return {
	setup = function()
		G, UI = Polestar.Gamepad, Polestar.UI
		uistub.setGuide(uistub.elwynn, 3)
	end,
	probes = {
		["gamepad.withMouse"] = function() return { active = G.IsActive(), holds = holds(), hints = hints() } end,
		["gamepad.navigate"] = { with = MOUSE, probe = holds },
		["gamepad.hints"] = { with = MOUSE, probe = hints },
		["gamepad.glyphs"] = { with = MOUSE, value = "playstation", probe = chip },
		["action:POLESTAR_NEXT"] = bound("POLESTAR_NEXT"),
		["action:POLESTAR_PREV"] = bound("POLESTAR_PREV"),
		["action:POLESTAR_NEXT_WAYPOINT"] = bound("POLESTAR_NEXT_WAYPOINT"),
		["action:POLESTAR_PREV_WAYPOINT"] = bound("POLESTAR_PREV_WAYPOINT"),
		["action:POLESTAR_FOCUS"] = bound("POLESTAR_FOCUS"),
		["action:POLESTAR_TOGGLE"] = bound("POLESTAR_TOGGLE"),
		["action:POLESTAR_HIDE"] = bound("POLESTAR_HIDE"),
		["action:POLESTAR_REOPEN_TAB"] = bound("POLESTAR_REOPEN_TAB"),
		["action:POLESTAR_MENU"] = bound("POLESTAR_MENU"),
		["action:POLESTAR_OPTIONS"] = bound("POLESTAR_OPTIONS"),
		["action:POLESTAR_REPORT"] = bound("POLESTAR_REPORT"),
		["action:POLESTAR_MARK_JUNK"] = bound("POLESTAR_MARK_JUNK"),
		["action:POLESTAR_MARK_KEEP"] = bound("POLESTAR_MARK_KEEP"),
		["action:CLICK PolestarQuestItemButton:LeftButton"] = bound("CLICK PolestarQuestItemButton:LeftButton"),
		["action:CLICK PolestarTargetButton:LeftButton"] = bound("CLICK PolestarTargetButton:LeftButton"),
		["action:CLICK PolestarRareButton:LeftButton"] = bound("CLICK PolestarRareButton:LeftButton"),
		["action:CLICK PolestarHearthButton:LeftButton"] = bound("CLICK PolestarHearthButton:LeftButton"),
		["action:CLICK PolestarStepButton:LeftButton"] = bound("CLICK PolestarStepButton:LeftButton"),
		["action:CLICK PolestarTravelButton:LeftButton"] = bound("CLICK PolestarTravelButton:LeftButton"),
	},
}
