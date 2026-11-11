-- env: world
-- The Guide page's frames and positions (Polestar_Options/UI/Options.lua, Movers.lua; Core/Init.lua's drag lock,
-- Nav/Arrow.lua, UI/Launcher.lua, Maps/MinimapButton.lua) and its "new in Forever" mark (Quests/NewQuests.lua) on
-- the whole addon, as ui-movers.rs plays unlock mode: the floating button turned on, its box dragged, the grid's
-- lines, Reset all positions, the arrow moved and put back, a guide whose accept is a quest new in Forever.
local M, GF
local function r(v) return math.floor(v + 0.5) end
local function lock() if M.IsUnlocked() then M.Lock() end end
-- Unlock mode: its grid lines shown.
local function grid()
	M.Unlock()
	local n = 0
	for _, l in ipairs(M.GridLines()) do if l:IsVisible() then n = n + 1 end end
	lock()
	return n
end
-- The floating button's box dragged 297 px left of the screen's centre line... and 3 px off it: where it lands.
local function drag()
	Polestar.Set("ui.launcherPos", { 300, 300 })
	M.Unlock()
	local b = M.Box("launcher")
	local l, bt, w, h = M.Rect("launcher")
	stub.cursor = { l + w / 2, bt + h / 2 }
	stub.RunScript(b, "OnMouseDown", "LeftButton")
	stub.cursor = { 960 + 3, bt + h / 2 + 37 }
	PolestarMovers:GetScript("OnUpdate")(PolestarMovers, 0.02)
	stub.RunScript(b, "OnMouseUp", "LeftButton")
	local at = Polestar.Get("ui.launcherPos")
	lock()
	return at
end
local function point(f) local p, _, rp, x, y = f:GetPoint(1); return { p, rp, r(x or 0), r(y or 0) } end
-- A drag on the arrow: whether it moves.
local function arrowDrag()
	local A = PolestarNavArrow
	A.moving = nil
	stub.RunScript(A, "OnDragStart", "LeftButton")
	local moving = A.moving == true
	A:StopMovingOrSizing()
	A.moving = nil
	return moving
end
local LAUNCHER = { ["ui.launcher"] = true }
return {
	setup = function()
		M, GF = Polestar.Movers, Polestar.UI.GuideFrame
		local w = stub.world
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.moveTo(1429, 40, 50)
		Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
		Polestar.RegisterGuide({ id = "test/hud", pack = "test", title = "Hud", minLevel = 1, maxLevel = 10, steps = {
			{ goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 } } },
		} })
		Polestar.Engine.SetGuide("test/hud")
		-- A Threat Within as a quest Forever added (quests.rs's form).
		Polestar.NewQuests.Register(6, string.format("%06d", 783))
		Polestar.Fire("STEP_UPDATED")
		stub.advance(0.5)
		-- Unlock mode built once (the settings' addon's).
		M.Unlock()
		lock()
	end,
	settle = 0.3,
	probes = {
		["ui.lockHud"] = arrowDrag,
		["Guide:Move frames"] = { press = true, prepare = lock, cleanup = lock,
			probe = function() return { M.IsUnlocked() and true or false, PolestarMovers ~= nil and PolestarMovers:IsShown() or false } end },
		["movers.grid"] = grid,
		["movers.gridSize"] = { value = 8, probe = grid },
		["movers.snap"] = { with = { ["ui.launcher"] = true, ["movers.grid"] = false }, probe = drag },
		["Guide:Reset all positions"] = { press = true,
			prepare = function() Polestar.Set("ui.pos", { 100, 900 }); Polestar.Set("nav.arrowPos", { point = "TOP", relPoint = "TOP", x = 300, y = -300 }) end,
			probe = function() return { guide = point(PolestarGuideFrame), arrow = point(PolestarNavArrow) } end },
		["Guide:Reset arrow position"] = { press = true,
			prepare = function() Polestar.Set("nav.arrowPos", { point = "TOP", relPoint = "TOP", x = 300, y = -300 }) end,
			probe = function() return point(PolestarNavArrow) end },
		["ui.launcher"] = function() return PolestarLauncher ~= nil and PolestarLauncher:IsShown() or false end,
		["maps.minimapButton"] = function() return PolestarMinimapButton ~= nil and PolestarMinimapButton:IsShown() or false end,
		-- The accept's row: the quest's name with Forever's mark, or without.
		["ui.newInForever"] = function()
			for _, row in ipairs(GF.rows) do
				if row:IsShown() and row.psGoal then return row.Text:GetText() end
			end
			return false
		end,
	},
}
