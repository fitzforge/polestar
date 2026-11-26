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
	pane:SetPoint("TOPLEFT", holder, "TOPLEFT")
	pane:SetPoint("BOTTOMRIGHT", holder, "BOTTOMRIGHT")
	pane:Hide()
	-- Scroll children start at the viewport origin. A canvas lets the guide
	-- keep its inset while the native tabs extend into the extra clip room.
	local content = CreateFrame("Frame", nil, pane)
	content:SetSize(1, 1)
	pane:SetScrollChild(content)
	frame:SetParent(content)
	frame:SetClampedToScreen(false)
	frame:SetMovable(false)
	frame:SetFrameStrata(holder:GetFrameStrata())
	frame:SetFrameLevel(holder:GetFrameLevel() + 1)

	local adapter = {frame = frame, pane = pane, content = content, holder = holder, overflow = 0}
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
		-- Side tabs belong to the guide, not the quest tracker's width. Widen
		-- only the clipping viewport to the left; the guide stays host-width.
		-- Edge tabs take room above/below the guide inside the height limit.
		local left, edge = gf.TabsOutside()
		local top, bottom = gf.BarsBottom() and 0 or edge, gf.BarsBottom() and edge or 0
		self.tabTop, self.tabBottom = top * scale, bottom * scale
		pane:ClearAllPoints()
		pane:SetPoint("TOPLEFT", holder, "TOPLEFT", -left * scale, 0)
		pane:SetPoint("BOTTOMRIGHT", holder, "BOTTOMRIGHT")
		content:SetWidth(holder:GetWidth() + left * scale)
		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT", content, "TOPLEFT", left, -top)
	end
	function adapter:Layout(tracker, custom)
		if InCombatLockdown() then return end
		self.available = Skin.DockAvailableHeight(holder, tracker, custom)
		self:Place()
		gf.Layout()
		self:Place()
		local natural = frame:GetHeight() * frame:GetScale() + self.tabTop + self.tabBottom
		local styles = gf.TabStyleFrames()
		local side = styles and styles.side
		if side and side:IsShown() then natural = math.max(natural, side:GetHeight() * frame:GetScale()) end
		content:SetHeight(natural)
		local height = self.available and math.min(natural, self.available) or natural
		-- Polestar scrolls its goals. The outer pane handles optional sections
		-- when they alone exceed the available height.
		self.overflow = math.max(0, natural - height)
		pane:EnableMouseWheel(self.overflow > 0.5)
		pane:SetVerticalScroll(math.min(pane:GetVerticalScroll() or 0, self.overflow))
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
