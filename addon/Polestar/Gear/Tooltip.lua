-- Gear lines on item tooltips (bags, loot, vendors, quest rewards, chat
-- links, dungeon loot: every item tooltip Polestar.Hooks sees):
--   * is it an upgrade for this spec at this level, against what it would
--     replace ("Polestar · Arms   +12.4% upgrade · Head")
--   * on a quest reward choice, whether it is the one to take ("Best pick"),
--     when that pick is an upgrade; with none, the reward panel's own mark
--     (QoL: the choice that sells for most) decides, so nothing is said here
--
--   Gear.TooltipLine(link) -> left, right, r, g, b | nil       (the comparison)
--   Gear.TooltipLines(link) -> { { left, right, lr, lg, lb, rr, rg, rb }, ... }
--
-- Work happens only when a tooltip shows. The comparison is cached per link
-- (Gear.CompareToEquipped) and the reward pick per item (Gear.ChoiceOf);
-- both caches clear on GEAR_UPDATED (spec, level, equipment, item data).
-- Lines are added through Polestar.Hooks (Core/Hooks.lua: GameTooltip and
-- ItemRefTooltip, forbidden tooltips and secret links skipped, lines added
-- once per show).

local ADDON, ns = ...

local Gear = ns.Gear
local L = ns.L

local type, ipairs = type, ipairs
local abs = math.abs

local SAME = 0.05 -- percent: closer than this reads as "same"

-- Equipment slot -> the client's global naming it (HEADSLOT, ...): the
-- tooltip line names the slot in the game's own word, in every language.
local SLOT_GLOBAL = {
	[1] = "HEADSLOT", [2] = "NECKSLOT", [3] = "SHOULDERSLOT", [5] = "CHESTSLOT", [6] = "WAISTSLOT", [7] = "LEGSSLOT",
	[8] = "FEETSLOT", [9] = "WRISTSLOT", [10] = "HANDSSLOT", [11] = "FINGER0SLOT", [12] = "FINGER0SLOT",
	[13] = "TRINKET0SLOT", [14] = "TRINKET0SLOT", [15] = "BACKSLOT", [16] = "MAINHANDSLOT", [17] = "SECONDARYHANDSLOT",
	[18] = "RANGEDSLOT",
}

-- -> the slot's name in the client's language, or nil for a slot without one.
function Gear.SlotName(slot)
	local tag = SLOT_GLOBAL[slot]
	local s = tag and _G[tag]
	if type(s) == "string" and s ~= "" then return s end
	return nil
end

local function color(name, fr, fg, fb)
	local T = ns.Theme
	if T and T.Color then
		local r, g, b = T.Color(name)
		if r then return r, g, b end
	end
	return fr, fg, fb
end

local function prefix()
	local _, label = Gear.GetSpec()
	if label then return L["Polestar"] .. " · " .. L[label] end
	return L["Polestar"]
end

local REASON = {
	class = L["not for your class"], armor = L["armor you cannot wear"],
	weapon = L["weapon you cannot use"], dualwield = L["needs Dual Wield"],
	skill = L["weapon skill not trained"],
}

function Gear.TooltipLine(link)
	local r = Gear.CompareToEquipped(link)
	if not r or r.equipped then return nil end
	if not r.usable then
		if not r.reason then return nil end
		local cr, cg, cb = color("textMuted", 0.5, 0.54, 0.63)
		return prefix(), REASON[r.reason], cr, cg, cb
	end
	if not r.delta then return nil end
	local right, cr, cg, cb
	local later = (r.minLevel or 0) > (Gear.PlayerLevel and Gear.PlayerLevel() or 0)
	if r.empty then
		right = L["upgrade (empty slot)"]
		cr, cg, cb = color("success", 0.42, 0.85, 0.6)
	elseif not r.pct or abs(r.pct) < SAME then
		right = L["same as equipped"]
		cr, cg, cb = color("textMuted", 0.5, 0.54, 0.63)
	elseif r.pct > 0 then
		local text, outsized = Gear.GainText(r.pct)
		right = outsized and text or (text .. " " .. L["upgrade"])
		cr, cg, cb = color("success", 0.42, 0.85, 0.6)
	else
		right = Gear.GainText(r.pct) .. " " .. L["downgrade"]
		cr, cg, cb = color("danger", 0.96, 0.45, 0.45)
	end
	if later and (r.empty or (r.pct and r.pct > 0)) then
		right = right .. " " .. L["at level"] .. " " .. r.minLevel
		cr, cg, cb = color("warning", 0.98, 0.75, 0.3)
	end
	local slotName = r.slot and not r.empty and Gear.SlotName(r.slot)
	if slotName then right = right .. " · " .. slotName end
	return prefix(), right, cr, cg, cb
end

local function pickLine(id, out)
	local c = Gear.ChoiceOf(id)
	if not (c and c.pick and c.pick.upgrade) then return end
	local lr, lg, lb = color("textDim", 0.69, 0.72, 0.8)
	local q = c.quest.name or (L["Quest"] .. " " .. c.quest.id)
	if c.isPick then
		local r, g, b = color("success", 0.42, 0.85, 0.6)
		out[#out + 1] = { L["Best pick"], q, lr, lg, lb, r, g, b }
	else
		local r, g, b = color("textMuted", 0.5, 0.54, 0.63)
		local name = ns.ItemDB.ItemName(c.pick.entry.id) or (L["Item"] .. " " .. c.pick.entry.id)
		out[#out + 1] = { L["Reward pick"], name, lr, lg, lb, r, g, b }
	end
end

function Gear.TooltipLines(link)
	local out = {}
	if not Gear.IsEnabled() then return out end
	if ns.Get("gear.tooltip") then
		local left, right, r, g, b = Gear.TooltipLine(link)
		if left then
			local lr, lg, lb = color("textDim", 0.69, 0.72, 0.8)
			out[#out + 1] = { left, right, lr, lg, lb, r, g, b }
		end
	end
	if ns.Get("gear.pickTooltip") then
		local id = Gear.ItemID(link)
		if id then pickLine(id, out) end
	end
	return out
end

ns.Hooks.ItemLines("Gear", function(tooltip, link, itemID)
	if type(link) ~= "string" then link = itemID and ("item:" .. itemID) or nil end
	if not link then return end
	local H = ns.Hooks
	for _, l in ipairs(Gear.TooltipLines(link)) do
		H.AddLine(tooltip, l[1], l[2], l[3], l[4], l[5], l[6], l[7], l[8])
	end
end)
