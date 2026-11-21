local _, ns = ...
local Skin = ns.UI.TrackerDock

local watched, overridden, placing
local questList, questsHidden

local function Attached()
	local api = _G.ForeverCore and ForeverCore.TrackerHost or _G.ForeverTrackerHost
	return api and api.IsAttachedToQuestTracker and api.IsAttachedToQuestTracker()
end

local function ActiveDock()
	local guide = Skin.PolestarGuide()
	local adapter = guide and guide.dock
	return not ns.Hidden() and adapter and adapter.selected and adapter.holder:IsVisible() and adapter
end

local function UpdateQuestList(column)
	local section = _G.ForeverCoreQuestTracker
	if section and section ~= questList and type(section.GetContentsHeight) == "function" then
		questList = section
		questsHidden = nil
		local getHeight = section.GetContentsHeight
		-- This is ForeverCore's replacement section, not Blizzard's quest
		-- module. Its setting and the native modules' collapsed state stay put.
		section.GetContentsHeight = function(self, ...)
			if self == questList and questsHidden then return 0 end
			return getHeight(self, ...)
		end
		section:HookScript("OnShow", function(self)
			if self == questList and questsHidden and not InCombatLockdown() then self:Hide() end
		end)
	end
	if not questList then return end
	local hidden = not not ActiveDock()
	local changed = hidden ~= questsHidden
	questsHidden = hidden
	if hidden and questList:IsShown() then questList:Hide() end
	if changed then
		if questList.MarkDirty then questList:MarkDirty() end
		if column and column.MarkDirty then column:MarkDirty() end
	end
end

local function Place(column)
	if placing or InCombatLockdown() then return end
	local adapter = ActiveDock()
	if not (adapter and Attached() and column:IsVisible()) then return end
	local holder = adapter.holder
	local scale = column:GetEffectiveScale()
	if not scale or scale <= 0 then return end
	local ratio = holder:GetEffectiveScale() / scale
	local left, right, top, bottom = holder:GetLeft(), holder:GetRight(), holder:GetTop(), holder:GetBottom()
	if not (left and right and top and bottom) then return end
	left, right, top, bottom = left * ratio, right * ratio, top * ratio, bottom * ratio
	local screenRatio = UIParent:GetEffectiveScale() / scale
	local width, height = UIParent:GetWidth() * screenRatio, UIParent:GetHeight() * screenRatio
	local gap, margin = 8 * screenRatio, 24 * screenRatio
	local x, y = left, bottom - gap
	if y - column:GetHeight() < margin then
		-- Keep the guide's full height. If the columns cannot fit vertically,
		-- put Forever's sections beside it rather than over it or off screen.
		x = left - column:GetWidth() - gap
		if x < margin then x = right + gap end
		y = math.min(top, height - margin)
	end
	x = math.max(0, math.min(x, math.max(0, width - column:GetWidth())))
	placing = true
	column:ClearAllPoints()
	column:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
	placing = false
	overridden = column
end

function Skin.UpdateForeverColumn()
	if InCombatLockdown() then return end
	local column = _G.ForeverTrackerCompanion
	UpdateQuestList(column)
	if column and watched ~= column then
		watched = column
		-- Only the addon-owned companion is observed, never a protected
		-- tracker method. ForeverCore still owns its section layout.
		hooksecurefunc(column, "SetPoint", function() Place(column) end)
	end
	if column and ActiveDock() and Attached() then
		Place(column)
	elseif overridden then
		local previous = overridden
		overridden = nil
		if previous.MarkDirty then previous:MarkDirty() end
	end
end
