-- Pause's watcher, chat lines and commands (docs/ARCHITECTURE.md, "Pause";
-- the state and what it takes away: Core/Init.lua). Pause stops what
-- Polestar shows and steers with, not the Engine, which keeps following the
-- quest log.
--
-- Paused outside, it is "armed" and waits for the way in; in a dungeon,
-- raid, battleground or arena it is "inside" there. Back outside and alive
-- (a Spirit Healer's resurrection too) it resumes by itself and everything
-- is back as it was. Outside as a ghost or dead it stays paused, so a wipe
-- and the run back do not end it: PLAYER_UNGHOST and PLAYER_ALIVE check
-- again (PLAYER_ALIVE also fires on releasing, still a ghost). An armed
-- pause that never went in lasts through a /reload or a logout, until an
-- entry into the world finds it armed for more than two hours. Every way
-- out of an instance passes a loading screen; the check runs a frame after
-- the events, so the client's instance state has settled.
--
-- Client: UnitIsGhost, UnitIsDeadOrGhost (through Compat.Readable),
-- IsInInstance and GetInstanceInfo (through Compat), GetBindingKey,
-- GetBindingText.

local ADDON, ns = ...
local L = ns.L

local type = type

-- pause.map: the step's map pins go too (Nav/Layers.lua,
-- Nav/Upcoming.lua); pause.automation: quest auto-accept and turn-in
-- wait (Core/Automation.lua, QoL/Rewards.lua).
ns.RegisterDefaults("pause", { map = false, automation = false })

-- Seconds an armed pause waits for a dungeon before it resumes.
local ARMED_FOR = 2 * 60 * 60

local function readable(v)
	local C = ns.Compat
	if C and C.Readable then return C.Readable(v) end
	return v
end

local function deadOrGhost()
	if UnitIsGhost and readable(UnitIsGhost("player")) then return true end
	if UnitIsDeadOrGhost and readable(UnitIsDeadOrGhost("player")) then return true end
	return false
end

local function now()
	local C = ns.Compat
	local n = C and C.Now and C.Now()
	if type(n) ~= "number" then n = time and time() or 0 end
	return n
end

---------------------------------------------------------------------------
-- The watcher
---------------------------------------------------------------------------

local pending, entering = false, false

local function evaluate()
	pending = false
	local fromWorld = entering
	entering = false
	local state = ns.Paused()
	if not state then return end
	-- Armed too long ago, it resumes before anything else: also on a way in, so a
	-- dungeon days later is not taken for the one it was armed for.
	if state == "armed" and fromWorld then
		local s = ns.CharState().pause
		if type(s) == "table" and type(s.at) == "number" and now() - s.at > ARMED_FOR then
			ns.SetPaused(false, "expired")
			return
		end
	end
	if ns.PauseInside() then
		-- Armed to inside, or into another instance (a no-op in the same one).
		ns.SetPaused(true, "entered")
		return
	end
	if state == "armed" then return end
	-- Outside after being in: only alive (a wipe's ghost keeps it paused).
	if deadOrGhost() then return end
	ns.SetPaused(false, "left")
end

local function soon(fromWorld)
	if fromWorld then entering = true end
	if pending then return end
	pending = true
	if C_Timer and C_Timer.After then
		ns.After(0, evaluate)
	else
		evaluate()
	end
end

ns.RegisterEvent("PLAYER_ENTERING_WORLD", function() soon(true) end)
ns.RegisterEvent("ZONE_CHANGED_NEW_AREA", function() soon(false) end)
ns.RegisterEvent("PLAYER_UNGHOST", function() soon(false) end)
ns.RegisterEvent("PLAYER_ALIVE", function() soon(false) end)

---------------------------------------------------------------------------
-- What it says
---------------------------------------------------------------------------

-- How to resume by hand: the key binding (when bound, named as the client
-- names it), else the minimap button's menu (when the button is on), else
-- /polestar resume (never with the gamepad interface, which has no slash
-- commands). Asking for the guide window resumes too.
function ns.PauseHowToEnd()
	local key = GetBindingKey and GetBindingKey("POLESTAR_PAUSE")
	if key == "" then key = nil end
	local named = key and GetBindingText and GetBindingText(key)
	if type(named) == "string" and named ~= "" then key = named end
	if key then return L["Press %s to resume, or open the guide window."]:format(key) end
	if ns.Get("maps.minimapButton") then return L["Right-click the minimap button and pick Pause to resume, or open the guide window."] end
	if ns.GamepadUI() then return L["Open the guide window to resume."] end
	return L["Type /polestar resume, or open the guide window."]
end

-- One chat line for every change but the way in (and a notice at the top of
-- the screen as it is paused by hand, saying how to resume).
ns.On("POLESTAR_PAUSED", function(state, why)
	if state then
		if why ~= "hand" then return end
		local howTo = ns.PauseHowToEnd()
		ns.Print(L["Polestar is paused: the arrow and the guide window step aside. It resumes by itself when you leave the dungeon alive."] .. " " .. howTo)
		local alerts = ns.Nav and ns.Nav.alerts
		if alerts and alerts.ShowNotice then alerts.ShowNotice(L["Polestar is paused"], howTo, 10) end
		return
	end
	-- "Back" only when the guide is: hidden Polestar, the window off, or an
	-- instance it waits out keep it away (ns.GuideShown), and the line says less.
	local back = ns.GuideShown()
	if why == "expired" then
		ns.Print(L["Paused for two hours without a dungeon: Polestar resumed."])
	elseif why == "window" and not ns.Hidden() then
		-- The window was asked for, and shows (UI/UI.lua, GuideFrame's APPLY).
		ns.Print(L["Polestar resumed: the guide window is back."])
	elseif not back then
		ns.Print(L["Polestar resumed."])
	elseif why == "left" then
		ns.Print(L["Polestar resumed: you are back out of the dungeon."])
	else
		ns.Print(L["Polestar resumed: the arrow and the guide window are back."])
	end
	-- A notice saying how to resume goes with it.
	local alerts = ns.Nav and ns.Nav.alerts
	if alerts and alerts.HideNotice then alerts.HideNotice() end
end)

---------------------------------------------------------------------------
-- The commands: /polestar pause toggles, `on` and `off` set; /polestar
-- resume resumes. Quiet (Init.lua's RegisterCommand): they leave hiding as
-- it is.
---------------------------------------------------------------------------

local function notPaused() ns.Print(L["Polestar is not paused."]) end

ns.RegisterCommand("pause", function(rest)
	local arg = ((rest or ""):match("^%s*(%S*)") or ""):lower()
	if arg == "" then
		ns.TogglePaused("hand")
	elseif arg == "on" then
		if ns.Paused() then return ns.Print(L["Polestar is already paused."]) end
		ns.SetPaused(true, "hand")
	elseif arg == "off" then
		if not ns.Paused() then return notPaused() end
		ns.SetPaused(false, "hand")
	else
		ns.Print(L["Usage: /polestar pause [on | off]"])
	end
end, L["Pause the guide: the arrow and the guide window step aside, and it resumes by itself when you leave the dungeon alive (on, off)"], true)

ns.RegisterCommand("resume", function()
	if not ns.Paused() then return notPaused() end
	ns.SetPaused(false, "hand")
end, L["Resume a paused guide"], true)
