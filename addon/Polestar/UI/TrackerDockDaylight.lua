local _, ns = ...
local Skin = ns.UI.TrackerDock

-- Daylight owns a replacement tracker. Keep its filters and quest settings
-- intact: this host supplies an independent, persistent guide/quests row.
function Skin.InstallDaylightDock()
	local dui = _G.DaylightUI
	local api = dui and dui.API
	if not api or api.major ~= 1 or not api.GetFrame or not api.For then return end
	local p = ns
	if not Skin.Enabled() then return end
	-- Released standalone 1.0.6+ supplies this host using our guide adapter
	-- and setting. Let it finish loading rather than create duplicate tabs.
	if ns.Compat.AddOnPresent("Polestartrackerdock") then
		local metadata = C_AddOns and C_AddOns.GetAddOnMetadata or GetAddOnMetadata
		local version = metadata and metadata("Polestartrackerdock", "Version") or ""
		local major, minor, patch = tostring(version):match("^(%d+)%.(%d+)%.(%d+)")
		if major and (tonumber(major) > 1 or (tonumber(major) == 1 and (tonumber(minor) > 0 or tonumber(patch) >= 6))) then return end
	end
	local plugin = api.For("Polestar")
	local host = {}
	Skin.DaylightHost = host
	local module, tracker, parts, strip, holder, adapter
	local selected, changing, suspended, pending = false, false, false, nil
	local hiddenParts = {}
	local hooked = false
	local buttons = {}
	local original

	local function Combat() return InCombatLockdown and InCombatLockdown() end
	local function Settings(path) return api.GetSetting("Quests", path) end
	local function Wanted()
		if not api.IsModuleEnabled("Quests") then return false end
		module = dui:GetModule("Quests")
		parts = module and module.ns
		tracker = parts and parts.Tracker
		return tracker and tracker.Wanted and tracker.Wanted() or false
	end
	function host.CanDock()
		-- Once attached, retain ownership while a tracker is temporarily off.
		-- Falling through would let another host attach the same guide twice.
		return adapter ~= nil or Wanted()
	end
	function host.IsTracker(frame) return tracker and frame == tracker.view end
	function host.MaxHeight()
		local height = Settings("maxHeight")
		if type(height) == "number" and not (issecretvalue and issecretvalue(height)) and height > 0 then return height end
	end
	-- Existing hosts register a guide here. This one creates it after Daylight's
	-- tracker is built, including when that happens after PLAYER_LOGIN.
	function host.RegisterGuide() end

	local function ConcealQuests()
		if not selected or suspended or Combat() then return end
		-- Item buttons are a separate secure column, not children of the list.
		-- Hide only out of combat and let Daylight continue updating their data.
		local candidates = {tracker.view, tracker.box, tracker.controls}
		if parts.Items then candidates[#candidates + 1] = parts.Items.holder end
		-- Daylight parents its scrollbar beside the view, not inside it.
		-- Hiding the list alone leaves a full quest-height bar on the guide.
		if parts.Scroll then candidates[#candidates + 1] = parts.Scroll.bar end
		for _, frame in ipairs(candidates) do
			if frame then
				if hiddenParts[frame] == nil then hiddenParts[frame] = frame:IsShown() end
				frame:Hide()
			end
		end
	end
	local function RestoreQuests()
		if Combat() then return end
		for frame, shown in pairs(hiddenParts) do frame:SetShown(shown) end
		wipe(hiddenParts)
		-- Re-evaluate optional background and filters using current settings,
		-- rather than a snapshot taken before quests/settings changed.
		if tracker and tracker.built then
			tracker.FitBox(tracker.viewNow or tracker.view:GetHeight())
			tracker.Hovered()
			if parts.Scroll and parts.Scroll.Paint then parts.Scroll.Paint() end
		end
	end
	local function Paint()
		local header = tracker.frames and tracker.frames["section:quests"]
		local look = tracker.Look()
		local previous
		for _, key in ipairs({"quests", "polestar"}) do
			local button = buttons[key]
			local on = (key == "polestar") == selected
			local text = key == "quests" and (QUESTS_LABEL or p.L["Quests"]) or "Polestar"
			if header and header.label then
				local font, size, flags = header.label:GetFont()
				if font and size then button.label:SetFont(font, size, flags or "") end
			else
				local _, _, flags = button.label:GetFont()
				local font = api.FontFile and parts.MEDIA and api.FontFile(parts.MEDIA.font) or api.Font()
				button.label:SetFont(font, Settings("sizes.header") or 12, flags or "")
			end
			if on then
				parts.Look.PaintText(button.label, look, "header", dui.Style.Upper(text))
			else
				button.label:SetText(dui.Style.Upper(text))
				button.label:SetTextColor(unpack(api.Colors().OFF))
			end
			button:SetSize(math.ceil(button.label:GetStringWidth()) + 12, math.ceil(button.label:GetStringHeight()) + 8)
			button:ClearAllPoints()
			if previous then button:SetPoint("LEFT", previous, "RIGHT", 8, 0)
			else button:SetPoint("TOPLEFT", strip, "TOPLEFT", -6, 0) end
			previous = button
		end
		strip:SetHeight(buttons.quests:GetHeight() + 3)
		parts.Look.PaintTexture(strip.rule, look, "headerLine", 0.9)
		if Settings("box") then
			api.Skin(holder, {window = true, noBorder = Settings("boxBorder") == false,
				bgAlpha = Settings("boxAlphaOwn") and Settings("boxAlpha") or nil})
		elseif holder.psDaylightBox then
			api.Skin(holder, {noBorder = true, noBackground = true, noBevel = true})
		end
		holder.psDaylightBox = Settings("box") and true or false
	end
	local function Layout()
		if not strip or suspended or Combat() then return end
		local view = tracker.view
		local scale = view:GetEffectiveScale() / UIParent:GetEffectiveScale()
		strip:SetScale(scale)
		holder:SetScale(scale)
		strip:ClearAllPoints()
		strip:SetPoint("BOTTOMLEFT", view, "TOPLEFT", 0, 6)
		strip:SetPoint("BOTTOMRIGHT", view, "TOPRIGHT", 0, 6)
		holder:ClearAllPoints()
		holder:SetPoint("TOPLEFT", view, "TOPLEFT")
		holder:SetPoint("TOPRIGHT", view, "TOPRIGHT")
		local strata = tracker.holder:GetFrameStrata()
		local level = tracker.holder:GetFrameLevel()
		strip:SetFrameStrata(strata)
		strip:SetFrameLevel(level + 10)
		holder:SetFrameStrata(strata)
		holder:SetFrameLevel(level + 5)
		if selected then adapter:Layout(view, false, false) end
		Paint()
		ConcealQuests()
	end
	function host.Select(mode)
		if not strip or changing then return end
		if Combat() then pending = mode; return end
		changing = true
		selected = mode == "polestar"
		ns.CharState().trackerDockTab = selected and "polestar" or "quests"
		if not selected then RestoreQuests() end
		holder:SetShown(selected and not suspended)
		adapter:SetSelected(selected and not suspended, selected and not suspended)
		Layout()
		changing = false
	end

	local function Build()
		local gf = p.UI.GuideFrame
		if not (gf and gf.frame and tracker.built and tracker.view) or gf.dock then return false end
		original = {parent = gf.frame:GetParent(), strata = gf.frame:GetFrameStrata(), level = gf.frame:GetFrameLevel()}
		strip = CreateFrame("Frame", "PolestarDaylightDockTabs", UIParent)
		strip.rule = strip:CreateTexture(nil, "ARTWORK")
		strip.rule:SetColorTexture(1, 1, 1, 1)
		strip.rule:SetPoint("BOTTOMLEFT")
		strip.rule:SetPoint("BOTTOMRIGHT")
		strip.rule:SetHeight(1)
		holder = CreateFrame("Frame", "PolestarDaylightDockContent", UIParent)
		holder:SetHeight(1)
		holder:EnableMouse(true)
		holder:Hide()
		local attach = Skin.AttachPolestar
		changing = true
		adapter = attach(holder, function() host.Select("polestar") end, function() host.Select("quests") end)
		changing = false
		if not adapter then strip:Hide(); holder:Hide(); strip = nil; return false end
		for _, key in ipairs({"quests", "polestar"}) do
			local button = CreateFrame("Button", nil, strip)
			button.label = api.Text(button, "small", "LEFT")
			button.label:SetPoint("LEFT", button, "LEFT", 6, 0)
			button:SetScript("OnClick", function() host.Select(key) end)
			buttons[key] = button
		end
		if not hooked then
			hooked = true
			-- Hook module functions via the plugin API, not frame methods.
			for _, name in ipairs({"Render", "Hovered", "FitBox"}) do plugin.Hook(tracker, name, ConcealQuests) end
			if parts.Items and parts.Items.Follow then plugin.Hook(parts.Items, "Follow", ConcealQuests) end
			if parts.Scroll and parts.Scroll.Paint then plugin.Hook(parts.Scroll, "Paint", ConcealQuests) end
		end
		local saved = ns.CharState().trackerDockTab
		host.Select(saved == "polestar" and p.Get("ui.shown") ~= false and "polestar" or "quests")
		return true
	end

	local empty
	local function Suspend()
		if not adapter or suspended then return end
		changing, suspended = true, true
		RestoreQuests()
		strip:Hide()
		holder:Hide()
		do
			local gf, frame = p.UI.GuideFrame, adapter.frame
			gf.dock = nil
			frame:SetParent(original.parent)
			if not empty then empty = CreateFrame("Frame", nil, adapter.pane); empty:SetSize(1, 1); empty:Hide() end
			adapter.pane:SetScrollChild(empty)
			adapter.pane:Hide()
			frame:SetFrameStrata(original.strata)
			frame:SetFrameLevel(original.level)
			frame:SetClampedToScreen(true)
			frame:SetMovable(true)
			frame:SetScale(p.Get("ui.scale") or 1)
			gf.ApplyPosition()
			gf.ApplyLock()
			gf.ApplyStyle()
			gf.Layout()
			gf.ApplyVisibility()
		end
		changing = false
	end
	local function Resume()
		changing = true
		do
			local gf, frame = p.UI.GuideFrame, adapter.frame
			gf.dock = adapter
			frame:SetParent(adapter.pane)
			adapter.pane:SetScrollChild(frame)
			frame:SetClampedToScreen(false)
			frame:SetMovable(false)
			frame:SetFrameStrata(holder:GetFrameStrata())
			frame:SetFrameLevel(holder:GetFrameLevel() + 1)
			gf.ApplyLock()
			gf.ApplyStyle()
		end
		suspended = false
		changing = false
		host.Select(selected and "polestar" or "quests")
	end

	local elapsed = 0
	local events = CreateFrame("Frame")
	events:RegisterEvent("PLAYER_REGEN_ENABLED")
	events:SetScript("OnEvent", function()
		if pending then local mode = pending; pending = nil; host.Select(mode) end
	end)
	events:SetScript("OnUpdate", function(_, dt)
		elapsed = elapsed + dt
		if elapsed < 0.2 or Combat() then return end
		elapsed = 0
		local wanted = Wanted()
		local target = wanted and api.GetFrame("questtracker")
		local visible = target and target:IsVisible() and not (api.IsAfkScreen and api.IsAfkScreen())
			and not p.Get("qol.hideQuestTracker") and not (p.GamepadUI and p.GamepadUI())
		if not visible then Suspend(); return end
		if not strip and not Build() then return end
		if suspended then Resume() end
		strip:Show()
		local hidden = p.Hidden and p.Hidden()
		if hidden and selected then host.Select("quests") end
		local alpha = target:GetAlpha()
		if strip:IsMouseOver() or (selected and holder:IsMouseOver()) then alpha = 1 end
		strip:SetAlpha(alpha)
		holder:SetAlpha(alpha)
		Layout()
	end)
end
