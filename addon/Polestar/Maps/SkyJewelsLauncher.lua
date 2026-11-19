local _, ns = ...
if ns.GamepadUI() then return end

local L = ns.L
local PACK = "Polestar_SkyJewels"

function ns.OpenSkyJewels()
	if ns.Compat.InCombat() then
		ns.Print(L["Sky Jewels opens after the fight."])
		return false
	end
	if not ns.SkyJewels and not (ns.Data.Pack(PACK) and ns.SkyJewels) then
		ns.Print(L["Sky Jewels could not be loaded. Is the Polestar_SkyJewels folder installed and enabled?"])
		return false
	end
	local arcade = ns.Arcade
	if arcade.IsOpen() then
		arcade.PutAway()
		if arcade.IsOpen() then
			ns.Print(L["Close Freedoom Arcade before opening Sky Jewels."])
			return false
		end
	end
	return ns.SkyJewels.Open()
end

ns.RegisterCommand("jewels", ns.OpenSkyJewels, L["Play Sky Jewels"])
SLASH_POLESTAR_SKYJEWELS1 = "/skyjewels"
SlashCmdList.POLESTAR_SKYJEWELS = function() ns.RunCommand("jewels") end
