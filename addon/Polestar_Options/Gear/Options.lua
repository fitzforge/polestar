-- Gear's rows on the Questing page's Rewards & gear tab (docs/ARCHITECTURE.md,
-- "Options registry"). The weights dropdown lists the player's own class
-- specs; the setting is kept per class (gear.spec.<CLASS>), so alts of other
-- classes keep "Automatic". Imported Pawn scales (Pawn.lua) follow the specs
-- as "Custom: <name>"; one button opens the window that manages them
-- (UI/GearScales.lua). A spec whose weights the player changed (Adjust.lua)
-- reads "<spec> (adjusted)", and Adjust weights opens the window that changes
-- them (UI/GearAdjust.lua). Part of the settings' addon: none of it is in
-- memory before the settings open.

local ns = Polestar

local Gear = ns.Gear
local L = ns.L

if not (Gear and ns.RegisterOptions) then return end

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

local playerClass

-- The built-in specs (marked when adjusted), then this class's custom scales.
local function choices()
	local out = {}
	for i = 1, #specChoices do
		local c = specChoices[i]
		if c.value ~= "auto" and Gear.Adjust.Count(playerClass, c.value) > 0 then
			c = { value = c.value, label = (L["%s (adjusted)"]):format(c.label) }
		end
		out[i] = c
	end
	for _, scale in ipairs(Gear.Scales.List(playerClass)) do
		out[#out + 1] = { value = "custom:" .. scale.id, label = (L["Custom: %s"]):format(scale.name) }
	end
	return out
end

local function UI() return ns.UI end

local registered = false

-- The rows, once the class is known: it is once logged in, and the settings
-- open after that.
local function register()
	if registered then return end
	local class = Gear.Client.PlayerClass()
	if not class then return end
	registered = true
	fillChoices(class)
	playerClass = class
	-- gear.enabled in the section's header; the comparison's threshold and
	-- pairing with the rest, each beside its neighbour.
	ns.RegisterOptions({
		page = L["Questing"], tab = L["Rewards & gear"], section = L["Gear advice"],
		toggle = { kind = "toggle", key = "gear.enabled", label = L["Gear advice"], search = "upgrades, stat weights, best in slot, bis, item score, compare gear",
			help = L["Score items for your class and talents and point out upgrades."] },
		controls = {
			{ kind = "dropdown", key = "gear.spec." .. class, label = L["Stat weights"], choices = choices, disabled = disabled,
				help = L["Which levelling weights score your items. Automatic follows the talent tree with the most points."] },
			{ kind = "toggle", key = "gear.useFlbis", label = L["Use Forever Leveling BiS when installed"], disabled = disabled,
				needs = function() return ns.Compat.AddOnPresent("ForeverLevelingBiS") end,
				search = "forever leveling bis, flbis, bis, upgrades, stat weights",
				help = L["With Stat weights on Automatic, gear advice takes Forever Leveling BiS's answers: its upgrade arrows in your bags, and from its next version its gains, its scores and the spec you picked in it."] },
			{ kind = "button", icon = "sliders", button = L["Adjust"], label = L["Adjust weights"], disabled = disabled,
				search = "stat weights, change weights, tweak, revert, default",
				help = L["Weigh a stat more or less than Polestar does for your spec. Revert to default puts Polestar's weights back."],
				onClick = function() if UI() and UI().ShowAdjust then UI().ShowAdjust() end end },
			{ kind = "button", icon = "bolt", button = L["Manage"], label = L["Manage custom weights"], disabled = disabled,
				help = L["Import a Pawn scale string, and use, rename, export or delete the scales you have."],
				onClick = function() if UI() and UI().ShowScales then UI().ShowScales() end end },
			{ kind = "toggle", key = "gear.tooltip", label = L["Tooltip comparison"], disabled = disabled, search = "compare items, item comparison, tooltip, upgrade",
				help = L["Show on item tooltips how much better or worse an item is than what you wear."] },
			{ kind = "slider", key = "gear.minUpgrade", label = L["Upgrade threshold"], min = 0, max = 10, step = 0.5,
				format = "%.1f%%", disabled = disabled,
				help = L["Smaller gains than this are not called upgrades."] },
			{ kind = "toggle", key = "gear.bagArrows", label = L["Upgrade arrows in bags"], disabled = disabled, search = "bags, upgrade icon, green arrow, inventory",
				help = L["A green arrow on each item in your bags that is an upgrade for your spec, in the game's bags and in Baganator."] },
			{ kind = "toggle", key = "gear.hideForPawn", label = L["Leave bag arrows to Pawn"], disabled = disabled,
				needs = function() return ns.Compat.AddOnPresent("Pawn") end,
				help = L["Pawn is installed and draws its own upgrade arrows in your bags. Turn this on to hide Polestar's, so an item does not carry two."] },
			{ kind = "toggle", key = "gear.useBags", label = L["Pair with bag items"], disabled = disabled,
				help = L["Against a worn two-hander, weigh a one-hander together with the best off-hand piece in your bags."] },
			{ kind = "toggle", key = "gear.rewards", label = L["Reward pick in the guide"], disabled = disabled,
				help = L["Under a turn-in step, name the reward to take: an upgrade with its gain, else the best one you can use. The marks on the game's reward panel are under Quest rewards."] },
			{ kind = "toggle", key = "gear.pickTooltip", label = L["Reward pick on tooltips"], disabled = disabled,
				help = L["On a quest reward's tooltip, say whether it is the upgrade to take."] },
		},
	})
end

register()
ns.OnLogin(register)
