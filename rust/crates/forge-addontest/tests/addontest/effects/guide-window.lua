-- env: ui
-- The Guide page's window rows (Polestar_Options/UI/Options.lua, GuideOptions.lua; UI/GuideFrame*.lua) on the live
-- guide window with the UI stub's Elwynn guide open at a step with three goals and a long tip, as the Guide window
-- page's checks have it: what the window shows, its tip and its Up next list, its grip, and Reset position.
local GF, F, P
local function pos() local p, _, rp, x, y = F:GetPoint(1); return { p, rp, math.floor((x or 0) + 0.5), math.floor((y or 0) + 0.5) } end
local function rows() local n = 0 for _, r in ipairs(GF.rows) do if r:IsShown() and r.psGoal then n = n + 1 end end return n end
return {
	setup = function()
		GF = Polestar.UI.GuideFrame
		uistub.openTabs({ { uistub.elwynn, 3 } }, 1)
		F = PolestarGuideFrame
		P = GF.parts
	end,
	settle = 0.3,
	probes = {
		["ui.shown"] = function() return F:IsShown() and true or false end,
		-- The step's goals: the one person's, or the whole step's.
		["ui.wholeStep"] = rows,
		-- The step's tip: one line, or all of it.
		["ui.notesOpen"] = function() return { open = P.tip.psOpen or false, height = math.floor(P.tip:GetHeight() + 0.5) } end,
		-- Up next with three steps: their rows folded, or open.
		["ui.upcomingOpen"] = { with = { ["ui.upcoming"] = 3 }, probe = function() return math.floor(P.upnext:GetHeight() + 0.5) end },
		-- A drag on the step bar: whether the window moves; and its resize grip.
		["ui.locked"] = function()
			F.moving = nil
			stub.RunScript(P.nav, "OnDragStart", "LeftButton")
			local moving = F.moving == true
			F:StopMovingOrSizing()
			F.moving = nil
			local grip = P.grip or GF.grip
			return { moving = moving, grip = grip ~= nil and grip:IsShown() or false }
		end,
		-- The window moved, then Reset: back in its corner.
		["Guide:Reset position"] = { press = true, prepare = function() Polestar.Set("ui.pos", { 100, 900 }) end, probe = pos },
	},
}
