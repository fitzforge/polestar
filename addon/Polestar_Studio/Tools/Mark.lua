-- Mark (spec 5.1): `mark <npc> <icon> "note"` for the target; the icon from
-- a picker of the eight raid icons (the target's own raid mark first).

local ADDON, S = ...
local L = S.L
local UI = S.UI

local anchor

local function mark(n)
	UI.Prompt({ title = L["Mark"], label = L["A note on the mark (optional), such as \"pull first\" or \"sheep\"."], onAccept = function(text)
		UI.Resolve("Mark", "target", n, text ~= "" and text or nil)
	end })
end

function UI.MarkTarget(from)
	if not UI.Ready() then return end
	if not UnitExists("target") then
		UI.Say(L["Target the creature to mark first."], "warning")
		return
	end
	if not anchor then
		anchor = CreateFrame("Frame", nil, UIParent)
		anchor:SetSize(1, 1)
	end
	local at = from
	if not at then
		local x, y = GetCursorPosition()
		local s = UIParent:GetEffectiveScale()
		anchor:ClearAllPoints()
		anchor:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", x / s, y / s)
		at = anchor
	end
	local current = GetRaidTargetIndex and GetRaidTargetIndex("target")
	if current then
		UI.Menu(at, {
			{ text = L["Its current mark"], icon = UI.RaidIcon(current), onClick = function() mark(current) end },
			{ text = L["Another icon…"], onClick = function() UI.IconPicker(at, mark) end },
		})
	else
		UI.IconPicker(at, mark)
	end
end

S.Tools.Register({
	key = "mark", label = "Mark the target", tex = UI.RaidIcon(8), kit = "core",
	tip = "A raid icon over this mob's nameplate while the step is current, with a note.",
	run = function() UI.MarkTarget() end,
})
