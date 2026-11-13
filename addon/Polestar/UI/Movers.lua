-- Unlock mode's door in core: /polestar unlock and /polestar lock, the
-- mode's saved settings and ns.Movers. The mode itself (a box over every
-- movable frame, the grid, snapping, the bar; Polestar_Options/UI/Movers.lua)
-- is the settings' addon's, loaded the first time it is asked for, never at
-- login (UI.LoadOptions; not in a fight).
--
--   ns.Movers.Register(spec)    a frame's mover (the mode's file says what a
--                               spec holds), kept here until the mode loads
--   ns.Movers.IsUnlocked(), Lock()   false and nothing until it has loaded
--   ns.Movers.Unlock([key]), Toggle(), Rect(key), MoveTo(key, left, bottom),
--   Reset(key), ResetAll(), Keys(), Box(key), ... load the mode, then run as
--   it has them (in a fight Unlock and Toggle say no, as the mode does)

local ADDON, ns = ...
local L = ns.L

ns.RegisterDefaults("movers", { grid = true, gridSize = 32, snap = true })

local M = { pending = {} }
ns.Movers = M

function M.Register(spec)
	M.pending[#M.pending + 1] = spec
	return true
end

function M.IsUnlocked() return false end
function M.Lock() end

local function combat() return InCombatLockdown and InCombatLockdown() and true or false end

-- The mode's functions, each loading it first; it puts its own in their place.
local LOADS = { "Unlock", "Toggle", "Rect", "MoveTo", "Reset", "ResetAll", "Keys", "Box", "Selected", "Snap",
	"RectOf", "OffsetOf", "Ratio", "DragTo", "EndDrag", "Nudge", "GridLines", "Refresh" }
for _, name in ipairs(LOADS) do
	local stub
	stub = function(...)
		if combat() and (name == "Unlock" or name == "Toggle") then
			ns.Print(L["You can't move frames in combat."])
			return false
		end
		local UI = ns.UI
		if not (UI and UI.LoadOptions and UI.LoadOptions()) or M[name] == stub then return nil end
		return M[name](...)
	end
	M[name] = stub
end

ns.RegisterCommand("unlock", function() M.Toggle() end, L["Move Polestar's frames (again to lock them)"])
ns.RegisterCommand("lock", function() M.Lock() end, L["Lock Polestar's frames in place"])
