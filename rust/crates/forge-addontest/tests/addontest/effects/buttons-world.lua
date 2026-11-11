-- env: world
-- The Buttons page's floating and minimap buttons, its presets and the Hearthstone's two buttons
-- (Polestar_Options/QoL/ButtonsOptions.lua; UI/Launcher.lua, Maps/MinimapButton.lua, QoL/Buttons.lua,
-- Nav/Prompts.lua) on the whole addon: the live floating button (turned on for its looks), the minimap button, the
-- action button set and the travel button under the arrow.
local function rgba(t) local r, g, b, a = t:GetVertexColor(); return { r, g, b, a } end
local function pt(b) local p, _, rp, x, y = b:GetPoint(1); return { p, rp, x, y } end
local function icon(b) return { b.Icon:GetTexture(), rgba(b.Icon) } end
local LAUNCHER = { ["ui.launcher"] = true }
-- The Hearthstone's two buttons both up: the step says to hearth (the Hearthstone in the action set) while the
-- route's next leg is an item of another kind (the travel button under the arrow; on the Hearthstone itself the
-- step's button wins, Nav/Prompts.lua). own: which of them the switch read is about; the other must stay up, or
-- the check fails.
local LEG = { kind = "item", item = 18149, label = "Use the Recall Rune", from = { c = 0, wx = 0, wy = 800 }, to = { c = 0, wx = 900, wy = 0 } }
local WALK = { kind = "walk", label = "Walk", to = { c = 0, wx = 950, wy = 0 } }
local function pair(own)
	local N, Q = Polestar.Nav, Polestar.QoL
	local w = stub.world
	if (w.items[6948] or 0) == 0 then w.addItem(6948) end
	if (w.items[18149] or 0) == 0 then w.addItem(18149) end
	local getRoute, active, step = N.GetRoute, N.travel.Active, Q.CurrentStep
	local raw = { { t = "hearth", location = "Goldshire" } }
	local view = { index = 1, status = "current", goals = { { index = 1, t = "hearth", status = "active" } } }
	N.GetRoute = function() return { LEG, WALK }, 1 end
	N.travel.Active = function() return true end
	Q.CurrentStep = function() return view, raw end
	Q.Buttons.Refresh()
	Polestar.Fire("ROUTE_CHANGED", { LEG, WALK })
	stub.advance(0.2)
	local hearth = PolestarHearthButton:IsShown() and true or false
	local travel = _G.PolestarTravelButton ~= nil and PolestarTravelButton:IsShown() and true or false
	N.GetRoute, N.travel.Active, Q.CurrentStep = getRoute, active, step
	Q.Buttons.Refresh()
	Polestar.Fire("ROUTE_CHANGED", N.GetRoute())
	stub.advance(0.2)
	if own == "hearth" then
		if not travel then error("the travel button went with the Hearthstone in the set") end
		return hearth
	end
	if not hearth then error("the Hearthstone in the set went with the travel button") end
	return travel
end
return {
	probes = {
		["ui.launcherSize"] = { with = LAUNCHER, probe = function() return PolestarLauncher:GetWidth() end },
		["ui.launcherAlpha"] = { with = LAUNCHER, probe = function() return PolestarLauncher:GetAlpha() end },
		["ui.launcherIcon"] = { with = LAUNCHER, probe = function() return icon(PolestarLauncher) end },
		["ui.launcherBack"] = { with = LAUNCHER, probe = function() return PolestarLauncher.Back:IsShown() and true or false end },
		["maps.minimapButtonSize"] = function() return PolestarMinimapButton:GetWidth() end,
		["maps.minimapButtonIcon"] = function() return icon(PolestarMinimapButton) end,
		-- A preset card: the set's scale, its line-up and its opacity out of combat.
		["Buttons:Presets"] = function()
			local B = Polestar.QoL.Buttons
			return { B.Holder():GetScale(), pt(PolestarHearthButton), PolestarQuestItemButton:GetAlpha() }
		end,
		-- The Hearthstone's two buttons: each switch hides its own, never the other.
		["qol.hearthButton"] = function() return pair("hearth") end,
		["nav.castPrompt"] = function() return pair("travel") end,
	},
}
