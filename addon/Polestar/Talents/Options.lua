-- The talent settings on the Questing options page's Talents tab
-- (docs/ARCHITECTURE.md, "Options registry"; the rows are the settings'
-- addon's, Polestar_Options/Talents/Options.lua): a change repaints the plan.
-- talents.enabled switches the module off: no plan, no marks on the talent
-- frame, no reminders.

local ADDON, ns = ...
local T = ns.Talents

if not T then return end

ns.On("SETTING_CHANGED", function(path)
	if type(path) == "string" and path:find("^talents%.") then T.Refresh() end
end)
