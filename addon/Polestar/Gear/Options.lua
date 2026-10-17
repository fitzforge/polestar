-- The "Gear" options page, through the options registry
-- (Polestar.RegisterOptions, defined in Theme/Widgets.lua). Registered once every
-- file has loaded, so the registry exists whichever module defines it. The
-- weights dropdown lists the player's own class specs; the setting is kept
-- per class (gear.spec.<CLASS>), so alts of other classes keep "Automatic".

local ADDON, ns = ...

local Gear = ns.Gear
local L = ns.L

local specChoices = { { value = "auto", label = L["Automatic (talents)"] } }

local function fillChoices(class)
	local meta = class and Gear.CLASSES[class]
	if not meta then return false end
	for i = #specChoices, 2, -1 do specChoices[i] = nil end
	for _, spec in ipairs(meta.specs) do
		specChoices[#specChoices + 1] = { value = spec.key, label = L[spec.label] }
	end
	return true
end

local function disabled()
	return not ns.Get("gear.enabled")
end

local registered = false

local function register()
	if registered or not ns.RegisterOptions then return end
	local class = Gear.Client.PlayerClass()
	if not class then return end
	fillChoices(class)
	registered = true
	ns.RegisterOptions({
		page = L["Questing"], tab = L["Rewards & gear"], section = L["Gear advice"],
		controls = {
			{ kind = "toggle", key = "gear.enabled", label = L["Gear advice"],
				help = L["Score items for your class and talents and point out upgrades."] },
			{ kind = "dropdown", key = "gear.spec." .. class, label = L["Stat weights"], choices = specChoices, disabled = disabled,
				help = L["Which levelling weights score your items. Automatic follows the talent tree with the most points."] },
			{ kind = "toggle", key = "gear.tooltip", label = L["Tooltip comparison"], disabled = disabled,
				help = L["Show on item tooltips how much better or worse an item is than what you wear."] },
			{ kind = "toggle", key = "gear.bagArrows", label = L["Upgrade arrows in bags"], disabled = disabled,
				help = L["A green arrow on each item in your bags that is an upgrade for your spec, in the game's bags and in Baganator."] },
			{ kind = "toggle", key = "gear.rewards", label = L["Reward pick in the guide"], disabled = disabled,
				help = L["Under a turn-in step, name the reward to take: an upgrade with its gain, else the best one you can use. The marks on the game's reward panel are under Quest rewards."] },
			{ kind = "toggle", key = "gear.pickTooltip", label = L["Reward pick on tooltips"], disabled = disabled,
				help = L["On a quest reward's tooltip, say whether it is the upgrade to take."] },
		},
	})
	ns.RegisterOptions({
		page = L["Questing"], tab = L["Rewards & gear"], section = L["Comparison"],
		controls = {
			{ kind = "slider", key = "gear.minUpgrade", label = L["Upgrade threshold"], min = 0, max = 10, step = 0.5,
				format = "%.1f%%", disabled = disabled,
				help = L["Smaller gains than this are not called upgrades."] },
			{ kind = "toggle", key = "gear.useBags", label = L["Pair with bag items"], disabled = disabled,
				help = L["Against a worn two-hander, weigh a one-hander together with the best off-hand piece in your bags."] },
		},
	})
end

ns.OnInit(register)
ns.OnLogin(register)
