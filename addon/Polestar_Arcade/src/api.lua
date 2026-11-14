-- FreedoomArcadeAPI: what other addons may call. Everything else in FreedoomArcade is internal and may
-- change in any release; these stay as documented for a given version.
--
--   FreedoomArcadeAPI.version            1
--   FreedoomArcadeAPI.Open() -> ok       show the game window (never toggles it closed); false in combat
--                                        before the window was ever made (its keyboard setup is protected)
--   FreedoomArcadeAPI.Close(saveAndPause) -> saved
--                                        hide the window; with saveAndPause, first quick-save (in a level)
--                                        and pause until P, as on aggro. saved: the quick-save was written
--   FreedoomArcadeAPI.IsOpen() -> bool   the window is shown
--   FreedoomArcadeAPI.OnWindow(fn)       fn(frame) once the window is made (now, when it already is):
--                                        lets an addon that ships this copy frame the window in its look
local D = FreedoomArcade
local UI = D.UI

local API = { version = 1 }

function API.IsOpen()
	return UI.IsOpen() and true or false
end

function API.Open()
	if not UI.Window() and InCombatLockdown and InCombatLockdown() then return false end
	UI.Open()
	return true
end

function API.Close(saveAndPause)
	if not UI.IsOpen() then return false end
	if saveAndPause then return UI.SuspendAndClose() end
	UI.Close()
	return false
end

function API.OnWindow(fn)
	if type(fn) ~= "function" then return end
	local frame = UI.Window()
	if frame then
		pcall(fn, frame)
	else
		UI.windowHooks[#UI.windowHooks + 1] = fn
	end
end

FreedoomArcadeAPI = API
