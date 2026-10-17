-- The talent settings on the Questing options page's Talents tab
-- (docs/ARCHITECTURE.md, "Options registry"). talents.enabled switches the
-- module off: no plan, no marks on the talent frame, no reminders. The plan
-- itself is chosen per character in the Talents section.

local ADDON, ns = ...
local T = ns.Talents
local L = ns.L

if not (T and ns.RegisterOptions) then return end

local function off() return not T.Get("enabled") end
local function overlayOff() return off() or not T.Get("overlay") end

local ok, err = ns.RegisterOptions({
	page = L["Questing"], tab = L["Talents"], section = L["Talent plan"],
	controls = {
		{ kind = "toggle", key = "talents.enabled", label = L["Talent plans"],
			help = L["Follow a talent plan for your class and spec (/pole talents)."] },
		{ kind = "toggle", key = "talents.overlay", label = L["Mark the talent frame"], disabled = off,
			help = L["A ring on the next talent in your plan and a flag on points the plan does not spend."] },
		{ kind = "toggle", key = "talents.badges", label = L["Pick numbers"], disabled = overlayOff,
			help = L["Where each talent comes in your plan's order (#1, #2, ...)."] },
		{ kind = "toggle", key = "talents.tooltip", label = L["Plan in tooltips"], disabled = off,
			help = L["A line in each talent's tooltip: where it comes in the plan, or that it is off the plan."] },
		{ kind = "toggle", key = "talents.reminder", label = L["Remind me of unspent points"], disabled = off,
			help = L["A chat line naming the plan's next talent when a point is waiting."] },
	},
})
if not ok and geterrorhandler then geterrorhandler()(err) end

ns.On("SETTING_CHANGED", function(path)
	if type(path) == "string" and path:find("^talents%.") then T.Refresh() end
end)
