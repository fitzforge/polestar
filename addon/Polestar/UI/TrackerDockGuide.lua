local _, ns = ...
local Skin = ns.UI.TrackerDock

function Skin.PolestarGuide()
	return ns.UI.GuideFrame
end

function Skin.AttachPolestar(holder, openTab, closeTab)
	local gf = Skin.PolestarGuide()
	if not (gf and gf.frame) or gf.dock then return nil end
	local frame = gf.frame
	local pane = CreateFrame("ScrollFrame", "PolestarTrackerDockPane", holder)
	pane:SetAllPoints(holder)
	pane:Hide()
	frame:SetParent(pane)
	pane:SetScrollChild(frame)
	frame:SetClampedToScreen(false)
	frame:SetMovable(false)
	frame:SetFrameStrata(holder:GetFrameStrata())
	frame:SetFrameLevel(holder:GetFrameLevel() + 1)

	local adapter = {frame = frame, pane = pane, holder = holder, overflow = 0}
	local toast = ns.UI.ClassToast
	local strataOrder = { BACKGROUND = 1, LOW = 2, MEDIUM = 3, HIGH = 4, DIALOG = 5,
		FULLSCREEN = 6, FULLSCREEN_DIALOG = 7, TOOLTIP = 8 }
	local function RaiseReminder()
		local card = toast and toast.frame
		if not (card and adapter.selected and pane:IsVisible()) then return end
		local strata, level = frame:GetFrameStrata(), frame:GetFrameLevel()
		local column = _G.ForeverTrackerCompanion
		if column and column:IsVisible() then
			local other = column:GetFrameStrata()
			if (strataOrder[other] or 0) > (strataOrder[strata] or 0) then strata = other end
			level = math.max(level, column:GetFrameLevel())
		end
		card:SetFrameStrata(strata)
		card:SetFrameLevel(level + 5)
	end
	-- Spell, class, dungeon and update notices share this card. Its normal
	-- placement puts it behind the guide for the slide animation; while docked
	-- it must also clear the independent tracker column. Keep it outside the
	-- scroll pane and below higher window strata such as Options and tooltips.
	if toast and toast.Place then hooksecurefunc(toast, "Place", RaiseReminder) end
	local host = Skin.SharedHost()
	local savedTab = ns.CharState().trackerDockTab
	local firstSelection = true
	gf.dock = adapter
	gf.ApplyLock()
	gf.ApplyStyle()
	pane:EnableMouseWheel(false)
	pane:SetScript("OnMouseWheel", function(self, delta)
		local offset = self:GetVerticalScroll() or 0
		self:SetVerticalScroll(math.max(0, math.min(adapter.overflow, offset - delta * 40)))
	end)

	function adapter:Place()
		if InCombatLockdown() then return end
		local scale = math.max(1, holder:GetWidth()) / math.max(1, frame:GetWidth())
		frame:SetScale(scale)
		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT", pane, "TOPLEFT")
	end
	function adapter:Layout(tracker, custom, themed)
		if InCombatLockdown() then return end
		self.available = Skin.DockAvailableHeight(holder, tracker, custom)
		self:Place()
		gf.Layout()
		if themed and gf.parts and gf.parts.band then gf.parts.band:Hide() end
		local natural = frame:GetHeight() * frame:GetScale()
		local height = self.available and math.min(natural, self.available) or natural
		-- Polestar scrolls its goals. The outer pane handles optional sections
		-- when they alone exceed the available height.
		self.overflow = math.max(0, natural - height)
		pane:EnableMouseWheel(self.overflow > 0.5)
		if self.overflow <= 0.5 then pane:SetVerticalScroll(0) end
		holder:SetHeight(height)
		Skin.UpdateForeverColumn()
		RaiseReminder()
	end
	function adapter:SetSelected(selected, show)
		self.selected = selected
		if host and not firstSelection then
			ns.CharState().trackerDockTab = selected and "polestar" or (show and "fta" or "quests")
		end
		firstSelection = false
		pane:SetShown(selected)
		if selected and show then
			if not ns.Get("ui.shown") then ns.Set("ui.shown", true) end
			gf.ApplyVisibility()
		end
		Skin.UpdateForeverColumn()
		RaiseReminder()
	end
	frame:HookScript("OnHide", function() if not frame:IsShown() then closeTab() end end)
	ns.On("SETTING_CHANGED", function(path, value)
		if path == "ui.shown" then
			if value then openTab() else closeTab() end
		end
	end)
	if host and host.Select and (savedTab == "fta" or (savedTab == "polestar" and ns.Get("ui.shown"))) then
		-- The host completes its default selection after attaching the guide.
		C_Timer.After(0, function()
			if gf.dock == adapter and not ns.Hidden() then host.Select(savedTab) end
		end)
	end
	return adapter
end
