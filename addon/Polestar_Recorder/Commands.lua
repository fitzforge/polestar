-- /psrec: status, on | off, ui, mark <text>, trail on [label] | off, clear.

local ADDON, ns = ...
local L = ns.L

local tostring, GetTime, floor = tostring, GetTime, math.floor

local CLEAR_WINDOW = 30 -- seconds to confirm /psrec clear

---------------------------------------------------------------------------
-- Status
---------------------------------------------------------------------------

local function status()
	local st = ns.Stats()
	ns.Print(L["recording %s"]:format(ns.IsEnabled() and "|cff4fd18f" .. L["on"] .. "|r" or "|cffd14f4f" .. L["off"] .. "|r"))
	ns.Print(L["%d chunks waiting for the uploader (about %d KiB of %d KiB)"]:format(st.chunks, floor(st.bytes / 1024 + 0.5), ns.STORE_BYTES / 1024))
	if st.acked > 0 then
		ns.Print(L["last chunk the uploader confirmed: %d (newest: %d)"]:format(st.acked, st.seq))
	else
		ns.Print(L["the uploader has not confirmed a chunk yet (newest: %d)"]:format(st.seq))
	end
	ns.Print(L["install id: %s"]:format(tostring(st.install)))
	ns.Print(L["commands: /psrec on | off | ui | mark <text> | trail on [label] | trail off | clear"])
end

---------------------------------------------------------------------------
-- Slash command
---------------------------------------------------------------------------

local clearArmedAt

local commands = {}

commands.status = status

commands.on = function()
	ns.SetEnabled(true)
	ns.Print(L["recording %s"]:format("|cff4fd18f" .. L["on"] .. "|r"))
	if ns.RefreshPanel then ns.RefreshPanel() end
end

commands.off = function()
	ns.SetEnabled(false)
	ns.Print(L["recording %s"]:format("|cffd14f4f" .. L["off"] .. "|r"))
	if ns.RefreshPanel then ns.RefreshPanel() end
end

commands.mark = function(rest)
	if rest == "" then
		ns.Print(L["usage: /psrec mark <text>"])
		return
	end
	if not ns.IsEnabled() then
		ns.Print(L["recording is off; /psrec on first"])
		return
	end
	if ns.Rec("mark", ns.P(), rest) then
		ns.Print(L["marked: %s"]:format(rest))
	else
		ns.Print(L["mark not recorded (not in the world yet)"])
	end
end

-- /psrec trail on [label] | off | toggle: a dense position trail
-- (Trail.lua). toggle (the key binding, the window's button) starts with the
-- window's label, else the next spot's.
local function trailOn(label)
	if not ns.IsEnabled() then
		ns.Print(L["recording is off; /psrec on first"])
		return
	end
	if label == "" and ns.PanelLabel then label = ns.PanelLabel() or "" end
	local tr, running = ns.TrailStart(label)
	if not tr then
		ns.Print(L["trail already on: %s"]:format(running.label))
		return
	end
	ns.Print(L["trail on: %s (stops by itself after %d min; /psrec trail off to end)"]:format(tr.label, ns.TRAIL_MAX_MINUTES))
end

local function trailOff()
	local tr = ns.TrailStop("off")
	if tr then
		ns.Print(L["trail off: %s, %d points"]:format(tr.label, tr.n))
	else
		ns.Print(L["no trail running"])
	end
end

commands.trail = function(rest)
	local sub, label = rest:match("^(%S*)%s*(.-)$")
	sub = (sub or ""):lower()
	if sub == "on" then
		trailOn(label)
	elseif sub == "off" then
		trailOff()
	elseif sub == "toggle" then
		if ns.Trail() then trailOff() else trailOn("") end
	else
		ns.Print(L["usage: /psrec trail on [label] | trail off"])
	end
	if ns.RefreshPanel then ns.RefreshPanel() end
end

-- /psrec ui: the Recorder window (Panel.lua).
commands.ui = function()
	if ns.TogglePanel then ns.TogglePanel() end
end

-- /psrec clear: deletes every chunk not yet uploaded.
commands.clear = function(rest)
	local now = GetTime()
	if rest == "confirm" and clearArmedAt and now - clearArmedAt <= CLEAR_WINDOW then
		clearArmedAt = nil
		ns.ClearAll()
		ns.Print(L["every recording not yet uploaded was deleted"])
		return
	end
	clearArmedAt = now
	ns.Print(L["this deletes every recording not yet uploaded. Type |cffffd100/psrec clear confirm|r within %d seconds to proceed."]:format(CLEAR_WINDOW))
end

-- Polestar's Recorder page calls PolestarRecorder_Command. /psrec is not
-- registered with Forever's gamepad interface on: the chat box calls a
-- command and then closes itself in the command's taint, which blocks the
-- gamepad's actions until a reload (Polestar's Core/Init.lua, ns.GamepadUI).
-- The API is the answer; the CVar can stay "1" with the keyboard and mouse.
local function gamepadUI()
	local E = Enum and Enum.InputDeviceInterfaceType
	if not (E and E.Gamepad) then return false end
	local S = C_InputInterfaceStyle
	if S and S.GetCurrentStyle then return S.GetCurrentStyle() == E.Gamepad end
	local get = (C_CVar and C_CVar.GetCVar) or GetCVar
	return get and tonumber(get("InputDeviceInterfaceStyle")) == E.Gamepad or false
end

ns.GamepadUI = gamepadUI

function PolestarRecorder_Command(msg)
	local name, rest = (msg or ""):match("^%s*(%S*)%s*(.-)%s*$")
	name = (name or ""):lower()
	if name == "" then name = "status" end
	local fn = commands[name]
	if not fn then
		ns.Print(L["unknown command: %s"]:format(name))
		status()
		return
	end
	fn(rest or "")
end
if not gamepadUI() then
	SLASH_POLESTARREC1 = "/psrec"
	SLASH_POLESTARREC2 = "/polestarrec"
	SlashCmdList.POLESTARREC = PolestarRecorder_Command
end
